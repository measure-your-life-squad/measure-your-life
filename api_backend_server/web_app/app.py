from server import app
import database


if __name__ == "__main__":

    database.initialize_db(app.app)

    app.run(host="0.0.0.0", debug=True, use_reloader=False)
