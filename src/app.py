import flask
from flask import jsonify, request

app = flask.Flask(__name__)
app.config["DEBUG"] = True


@app.route('/hello', methods=['GET'])
def hello_world_api():
    return jsonify("Task has been updated successfully!")


@app.route('/vowel-service', methods=['POST'])
def vowel_service_api():
    def _reverse_vowels(original_string: str):
        vowels = ""
        for letter in original_string:
            if letter in "aeiouAEIOU":
                vowels += letter
        result_string = ""
        for letter in original_string:
            if letter in "aeiouAEIOU":
                result_string += vowels[-1]
                vowels = vowels[:-1]
            else:
                result_string += letter

        return result_string
    try:
        message = request.json["message"]
    except KeyError:
        return jsonify("Message not in request.")

    reversed_message_vowels = _reverse_vowels(message)

    return jsonify(reversed_message_vowels)


if __name__ == '__main__':
    app.run(host="0.0.0.0", port=5000)