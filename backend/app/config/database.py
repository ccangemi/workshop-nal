import os
from sqlalchemy import create_engine
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker
from urllib.parse import urlparse

Base = declarative_base()

class DatabaseConfig:
    def __init__(self):
        self.connection_string = os.getenv("DATABASE_CONNECTION_STRING")
        if not self.connection_string:
            raise ValueError("DATABASE_CONNECTION_STRING environment variable is required")

        self.engine = self._create_engine()
        self.SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=self.engine)

    def _create_engine(self):
        parsed_url = urlparse(self.connection_string)

        if parsed_url.scheme.startswith('mssql'):
            return create_engine(
                self.connection_string,
                pool_pre_ping=True,
                pool_recycle=300
            )
        elif parsed_url.scheme.startswith('mysql'):
            return create_engine(
                self.connection_string,
                pool_pre_ping=True,
                pool_recycle=300
            )
        else:
            return create_engine(
                self.connection_string,
                pool_pre_ping=True,
                pool_recycle=300
            )

    def get_db(self):
        db = self.SessionLocal()
        try:
            yield db
        finally:
            db.close()

db_config = DatabaseConfig()
get_db = db_config.get_db