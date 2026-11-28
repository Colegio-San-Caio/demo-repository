import json
import os

def lambda_handler(event, context):
    """
    AWS Lambda handler to serve pipeline metrics and metadata.
    """
    domain = "trafo.com"
    if os.path.exists("MAIN.LIB"):
        with open("MAIN.LIB", "r") as f:
            for line in f:
                if line.startswith("DOMAIN ="):
                    domain = line.split("=", 1)[1].strip()

    img_size = 0
    if os.path.exists("fat77.img"):
        img_size = os.path.getsize("fat77.img")

    body = {
        "status": "success",
        "signature": "FAT77-ADVANCED-SIG",
        "domain": domain,
        "image_size_bytes": img_size,
        "message": "Pipeline metrics retrieved successfully via C-native and Serverless backend."
    }

    return {
        "statusCode": 200,
        "headers": {"Content-Type": "application/json"},
        "body": json.dumps(body)
    }
