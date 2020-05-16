import os
import sys
import pathlib


web_app_dir = "web_app"

backend_root_path = pathlib.Path(__file__).parent.parent.absolute()
web_app_path = os.path.join(backend_root_path, web_app_dir)

sys.path.append(web_app_path)
