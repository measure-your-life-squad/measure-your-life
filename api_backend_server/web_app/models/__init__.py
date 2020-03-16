from sqlalchemy import Column, Integer, String, Boolean
from database import Base


class Users(Base):
    __tablename__ = 'users'
    id = Column(Integer, primary_key=True)
    public_id = Column(Integer)
    name = Column(String(50))
    password = Column(String(50))
    admin = Column(Boolean)


class Activities(Base):
    __tablename__ = 'activities'
    id = Column(Integer, primary_key=True)
    user_id = Column(Integer)
    name = Column(String(50), unique=False, nullable=False)
    activity_start = Column(String(50), unique=False, nullable=False)
    activity_end = Column(String(50), unique=False, nullable=False)
