"""API v1 routes"""
from fastapi import APIRouter
from app.api.v1 import auth, memories, categories, search

api_router = APIRouter()

api_router.include_router(auth.router, prefix="/auth", tags=["auth"])
api_router.include_router(memories.router, prefix="/memories", tags=["memories"])
api_router.include_router(categories.router, prefix="/categories", tags=["categories"])
api_router.include_router(search.router, prefix="/search", tags=["search"])

