# Usage: python get_status.py > last_status.txt
# Assumes the VISIONECT_* values are already set in the env
from vss_python_api import ApiDeclarations
import sys, os

my_api = ApiDeclarations(
    os.getenv("VISIONECT_API_URL"),
    os.getenv("VISIONECT_API_KEY"),
    os.getenv("VISIONECT_API_SECRET")
)
uuid = os.getenv("VISIONECT_DEVICE_UUID")
device_info = my_api.get_device(uuid)
print("Batt %s%%" % device_info[1]['Status']['Battery'])