from vss_python_api import ApiDeclarations
import sys, os

my_api = ApiDeclarations(
    os.getenv("VISIONECT_API_URL"),
    os.getenv("VISIONECT_API_KEY"),
    os.getenv("VISIONECT_API_SECRET")
)
uuid = os.getenv("VISIONECT_DEVICE_UUID")

img_name = sys.argv[1]
print("Pushing "+img_name)
fr = {'image': (img_name, open(os.path.join(sys.path[0], img_name), 'rb'), 'image/png', {'Expires': '0'})}
sc = my_api.set_http(uuid, fr)
if sc != 200:
	print("Error pushing image! HTTP status code %s" % sc)