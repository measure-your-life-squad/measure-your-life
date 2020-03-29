from sqlalchemy import Column, Integer, String, Boolean, ForeignKey
from sqlalchemy.orm import relationship
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
    category_id = Column(Integer, ForeignKey("categories.id"))


class Categories(Base):
    __tablename__ = 'categories'
    id = Column(Integer, primary_key=True)
    name = Column(String(50), unique=False, nullable=False)
    icon_name = Column(String(50), unique=False, nullable=True)
    activities = relationship("Activities")
