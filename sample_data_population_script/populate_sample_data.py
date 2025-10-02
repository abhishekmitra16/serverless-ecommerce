import boto3

dynamodb = boto3.resource('dynamodb')
table = dynamodb.Table('Products')

def populate_products():
    products = [
        {'product_id': 'prod1', 'name': 'Laptop', 'price': 999.99, 'stock': 10},
        {'product_id': 'prod2', 'name': 'Phone', 'price': 499.99, 'stock': 20}
    ]
    for product in products:
        table.put_item(Item=product)
    print("Products added")

if __name__ == "__main__":
    populate_products()