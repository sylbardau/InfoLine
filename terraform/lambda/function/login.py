import json
import boto3
import hashlib
import os
from datetime import datetime, timedelta

def lambda_handler(event, context):
    """
    Lambda function pour l'authentification InfoLine.
    Gère le login des visiteurs, utilisateurs et administrateurs.
    """
    
    http_method = event.get("httpMethod", "")
    path        = event.get("path", "")

    if http_method == "POST" and path == "/login":
        return handle_login(event)
    
    if http_method == "GET" and path == "/health":
        return response(200, {"status": "ok", "service": "infoline-auth"})

    return response(404, {"message": "Route non trouvée"})


def handle_login(event):
    try:
        body = json.loads(event.get("body", "{}"))
    except json.JSONDecodeError:
        return response(400, {"message": "Body JSON invalide"})

    email    = body.get("email", "").strip().lower()
    password = body.get("password", "")

    if not email or not password:
        return response(400, {"message": "Email et mot de passe requis"})

    # Récupération de l'utilisateur depuis DynamoDB
    user = get_user(email)
    if not user:
        return response(401, {"message": "Identifiants invalides"})

    # Vérification du mot de passe (hash SHA-256 + salt)
    if not verify_password(password, user.get("password_hash", ""), user.get("salt", "")):
        return response(401, {"message": "Identifiants invalides"})

    role = user.get("role", "user")  # "user" | "admin"

    token = generate_token(email, role)

    return response(200, {
        "message": "Connexion réussie",
        "token":   token,
        "role":    role,
        "email":   email
    })


def get_user(email):
    """Récupère un utilisateur depuis DynamoDB."""
    try:
        dynamodb = boto3.resource("dynamodb", region_name=os.environ.get("APP_REGION", "eu-west-3"))
        table    = dynamodb.Table(os.environ.get("USERS_TABLE", "infoline-users"))
        result   = table.get_item(Key={"email": email})
        return result.get("Item")
    except Exception as e:
        print(f"Erreur DynamoDB: {e}")
        return None


def verify_password(password, stored_hash, salt):
    """Vérifie le mot de passe avec SHA-256 + salt."""
    computed = hashlib.sha256(f"{password}{salt}".encode()).hexdigest()
    return computed == stored_hash


def generate_token(email, role):
    """Génère un token simple (à remplacer par JWT en production)."""
    payload  = f"{email}:{role}:{datetime.utcnow().isoformat()}"
    token    = hashlib.sha256(payload.encode()).hexdigest()
    return token


def response(status_code, body):
    return {
        "statusCode": status_code,
        "headers": {
            "Content-Type":                "application/json",
            "Access-Control-Allow-Origin": "*",
        },
        "body": json.dumps(body)
    }
