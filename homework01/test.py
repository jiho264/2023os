import json

with open('inputtmp.json') as f:
    json_object = json.load(f)

assert json_object['process_list']

print(json_object['process_list'][0]['bursttime'])
