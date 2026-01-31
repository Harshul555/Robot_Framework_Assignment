from robot.api import logger
from robot.api.interfaces import ListenerV3
from robot.libraries.BuiltIn import BuiltIn


class ScreenshotListener(ListenerV3):
    ROBOT_LISTENER_API_VERSION = 3

    def end_keyword(self, data, result):
        if result.status == 'FAIL':
            try:
                builtin = BuiltIn()
                selenium = builtin.get_library_instance('SeleniumLibrary')
                filename = selenium.capture_page_screenshot()
                logger.info(f'Screenshot captured: <a href="{filename}">{filename}</a>', html=True)
            except Exception as e:
                logger.debug(f"Could not capture screenshot: {str(e)}")
