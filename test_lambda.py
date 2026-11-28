import json
from app import lambda_handler

def test_local_lambda():
    print("Invoking local Lambda handler...")
    event = {}
    context = {}
    response = lambda_handler(event, context)
    
    print(f"Status Code: {response['statusCode']}")
    print(f"Headers: {response['headers']}")
    
    body = json.loads(response['body'])
    print("\nParsed Lambda Response Body:")
    print(json.dumps(body, indent=2))
    
    assert response['statusCode'] == 200, "Lambda returned non-200 status code."
    assert body['status'] == "success", "Lambda status is not success."
    print("\nLambda handler local verification passed successfully!")

if __name__ == "__main__":
    test_local_lambda()
