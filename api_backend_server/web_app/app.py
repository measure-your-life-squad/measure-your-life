from server import app
import database


@app.app.teardown_appcontext
def shutdown_session(exception=None):
    database.db_session.remove()


if __name__ == "__main__":

    database.init_db()

    app.run(host="0.0.0.0", debug=True, use_reloader=False)
