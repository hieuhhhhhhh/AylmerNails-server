from flask import jsonify
from src.mysql.procedures.call_3D_proc import call_3D_proc


def add_appo_by_chain(session, chain):
    # result holder
    appo_ids = []
    print(chain)

    return jsonify({"added_appo_id": appo_ids}), 200
