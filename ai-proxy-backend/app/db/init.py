from app.db.base import Base
from app.db.database import SessionLocal, engine
from app.db.seed import seed_database


def initialize_database():
    Base.metadata.create_all(bind=engine)

    db = SessionLocal()

    try:
        seed_database(db)
        db.commit()
    except Exception:
        db.rollback()
        raise
    finally:
        db.close()