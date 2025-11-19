from robot.api import logger
from robot.libraries.BuiltIn import BuiltIn
import time

class ValidationScreenshotListener:
    ROBOT_LIBRARY_SCOPE = 'GLOBAL'
    ROBOT_LISTENER_API_VERSION = 2

    def __init__(self):
        self.ROBOT_LIBRARY_LISTENER = self
        self.builtin = BuiltIn()
        self.last_failed_keyword = None  # Prevent duplicate screenshots for same keyword

    def start_keyword(self, name, attributes):
        # Reset last_failed_keyword if a new keyword starts
        pass

    def end_keyword(self, name, attributes):
        status = attributes.get("status", "").upper()

        # Capture screenshot for *every* failed keyword (avoid duplicate)
        if status == "FAIL" and self.last_failed_keyword != name:
            self.last_failed_keyword = name
            logger.console(f"❌ Keyword failed: {name}")
            self._capture_screenshot(name)
            self._check_logged_out_on_failure()

    def _capture_screenshot(self, keyword_name):
        """Takes a screenshot for each failed keyword."""
        try:
            logger.console(f"📸 Capturing screenshot for failure in: {keyword_name}")
            self.builtin.run_keyword("Take Screenshot", "EMBED")
        except Exception as e:
            logger.console(f"⚠️ Failed to capture screenshot: {e}")

    def _check_logged_out_on_failure(self):
        """Check for login page after a failure."""
        try:
            browser = self.builtin.get_library_instance("Browser")
            # retry up to 2 times (2 seconds total)
            for _ in range(2):
                count = browser.get_element_count("input#username")
                if count > 0:
                    logger.error("🚫 Fatal: Detected Login Page — user logged out.")
                    self.builtin.fatal_error("🚫 Logged out detected — stopping all tests.")
                    return
                time.sleep(1)
        except Exception:
            # ignore if Browser not initialized or closed
            pass
