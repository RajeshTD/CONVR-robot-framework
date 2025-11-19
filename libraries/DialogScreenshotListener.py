# libraries/DialogScreenshotListener.py
from robot.api import logger
from robot.libraries.BuiltIn import BuiltIn
import time

class DialogScreenshotListener:
    ROBOT_LISTENER_API_VERSION = 2

    def __init__(self):
        self.ROBOT_LIBRARY_LISTENER = self
        self.browser = None
        self.dialog_hooked = False

    def _get_browser(self):
        """Get Browser library instance."""
        if not self.browser:
            try:
                self.browser = BuiltIn().get_library_instance("Browser")
            except Exception:
                self.browser = None
        return self.browser

    def start_suite(self, name, attrs):
        """Hook dialog event listener once at suite start."""
        browser = self._get_browser()
        if not browser or self.dialog_hooked:
            return

        try:
            # Use Browser's stable API: get current pages
            pages = browser.get_browser_catalog()["default"]["contexts"][0]["pages"]

            for page in pages:
                page.on("dialog", self._on_dialog)

            self.dialog_hooked = True
            logger.console("✅ Dialog screenshot listener registered")

        except Exception as e:
            logger.console(f"⚠️ Could not hook dialog listener: {e}")

    def _on_dialog(self, dialog):
        """Called whenever a dialog appears."""
        ts = int(time.time())
        filename = f"dialog_{ts}.png"

        logger.console(f"⚡ Dialog appeared: {dialog.message}")
        logger.info(f"⚡ Dialog appeared: {dialog.message}")

        try:
            BuiltIn().run_keyword("Take Screenshot", filename)
            logger.info(f"📸 Screenshot saved: {filename}", also_console=True)
        except Exception as e:
            logger.console(f"Could not capture screenshot: {e}")

        # Always accept (you can change this to dismiss/input if needed)
        dialog.accept()
