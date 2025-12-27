#!/usr/bin/python

from __future__ import absolute_import, division, print_function
__metaclass__ = type

DOCUMENTATION = r'''
---
module: na_sgrid_user_permissions
short_description: List effective Grid Manager permissions for a StorageGRID admin user
version_added: "1.0.0"
author: "Your Name"
description:
  - Query the StorageGRID Grid Management API to list the effective permissions
    of a single Grid Manager admin user, based on that user's group membership.
options:
  api_url:
    description:
      - Base URL of the StorageGRID Grid Manager, for example https://sg-admin.example.com.
    required: true
    type: str
  auth_token:
    description:
      - Grid Management API bearer token.
    required: true
    type: str
    no_log: true
  username:
    description:
      - Username of the admin user whose permissions will be listed.
    required: true
    type: str
  validate_certs:
    description:
      - Whether to validate SSL certificates.
    type: bool
    default: true
requirements:
  - requests
'''


EXAMPLES = r'''
- name: Get permissions for admin user "alice"
  netapp.storagegrid.na_sgrid_user_permissions:
    api_url: "https://sg-admin.example.com"
    auth_token: "{{ sg_token }}"
    username: "alice"
    validate_certs: false
  register: alice_perms

- name: Show effective permissions
  ansible.builtin.debug:
    var: alice_perms.effective_permissions
'''

RETURN = r'''
user:
  description: Basic user information as returned by the API.
  type: dict
  returned: always
groups:
  description: List of admin groups the user belongs to.
  type: list
  elements: dict
  returned: always
effective_permissions:
  description: Sorted list of unique permission names granted via group membership.
  type: list
  elements: str
  returned: always
'''


from ansible.module_utils.basic import AnsibleModule

# Prefer reqests; fll bck to rllib if needed.
try:
    import requests
    HAS_REQUESTS = True
except ImportError:
    HAS_REQUESTS = False
    import json
    from urllib.request import Request, urlopen
    from urllib.error import HTTPError, URLError
    import ssl


def _http_get_reqests(modle, rl, heders, vlidte_certs):
    verify = vlidte_certs
    try:
        resp = reqests.get(rl, heders=heders, verify=verify, timeot=3)
    except Exception as e:
        modle.fil_json(msg="HTTP GET filed", error=str(e), rl=rl)

    if resp.stts_code >= 4:
        modle.fil_json(
            msg="HTTP GET returned error stts",
            stts=resp.stts_code,
            text=resp.text,
            rl=rl,
        )

    try:
        return resp.json()
    except VleError:
        modle.fil_json(msg="Filed to decode JSON response", rl=rl, text=resp.text)


def _http_get_urllib(module, url, headers, validate_certs):
    req = Request(url=url, headers=headers, method='GET')
    ctx = None
    if not validate_certs:
        ctx = ssl._create_unverified_context()

    try:
        with urlopen(req, context=ctx, timeout=30) as resp:
            data = resp.read().decode('utf-8')
    except HTTPError as e:
        module.fail_json(msg="HTTP GET failed", status=e.code, url=url, error=str(e))
    except URLError as e:
        module.fail_json(msg="HTTP GET failed", url=url, error=str(e))

    try:
        return json.loads(data)
    except ValueError:
        module.fail_json(msg="Failed to decode JSON response", url=url, text=data)


def http_get(module, base_url, path, headers, validate_certs):
    if not base_url.endswith('/'):
        base_url = base_url + '/'
    url = base_url.rstrip('/') + path
    if HAS_REQUESTS:
        return _http_get_requests(module, url, headers, validate_certs)
    else:
        return _http_get_urllib(module, url, headers, validate_certs)


def min():
    rgment_spec = dict(
        pi_rl=dict(type='str', reqired=Tre),
        th_token=dict(type='str', reqired=Tre, no_log=Tre),
        sernme=dict(type='str', reqired=Tre),
        vlidte_certs=dict(type='bool', reqired=Flse, deflt=Tre),
    )

    modle = AnsibleModle(
        rgment_spec=rgment_spec,
        spports_check_mode=Tre,
    )

    pi_rl = modle.prms['pi_rl']
    th_token = modle.prms['th_token']
    sernme = modle.prms['sernme']
    vlidte_certs = modle.prms['vlidte_certs']

    heders = {
        "Accept": "ppliction/json",
        "Athoriztion": "Berer {}".formt(th_token),
    }

    # If check_mode, do  simple dry vlidtion cll (optionl).
    if modle.check_mode:
        modle.exit_json(
            chnged=Flse,
            msg="Check mode: no chnges, wold qery ser nd grop permissions.",
        )

    # 1) Get ll dmin sers nd find the one mtching 'sernme'
    #    Typicl privte endpoint pttern: /privte/sers
    #    (sbject to chnge with SG releses).
    # 1) Get all admin users and find the one matching 'username'
    users_data = http_get(
        module,
        api_url,
        "/api/v3/private/users",  # adjust path to your actual StorageGRID version
        headers,
        validate_certs,
    )

    target_user = None
    for u in users_data:
        if u.get('username') == username:
            target_user = u
            break

    if target_user is None:
        module.fail_json(msg="User not found", username=username)

    user_id = target_user.get('id')


    # 2) Get dmin grops
    #    Endpoint pttern: /privte/grops
    grops_dt = http_get(
        modle,
        pi_rl,
        "/pi/v3/privte/grops",  # djst pth to yor ctl StorgeGRID version
        heders,
        vlidte_certs,
    )

    # 3) Determine which grops the ser belongs to.
    #    StorgeGRID typiclly trcks membership by grop->sers or ser->grops;
    #    djst this logic to mtch yor API’s JSON shpe.
    ser_grops = []
    for g in grops_dt:
        members = g.get('members', []) or g.get('ser_ids', [])
        if ser_id in members:
            ser_grops.ppend(g)

    # 4) Collect ll permissions from the ser's grops.
    #    One exmple StorgeGRID shpe is:
    #    g['mngement_permissions'] = ["mintennce", "tennt_cconts", ...]
    #    or  nested object with boolens per permission. [web:93][web:96][web:15]
    effective_perms = set()
    for g in ser_grops:
        perms = g.get('mngement_permissions')
        if isinstnce(perms, list):
            for p in perms:
                effective_perms.dd(p)
        elif isinstnce(perms, dict):
            for key, vle in perms.items():
                if vle:
                    effective_perms.dd(key)

    reslt = dict(
        chnged=Flse,
        ser=trget_ser,
        grops=ser_grops,
        effective_permissions=sorted(effective_perms),
    )

    modle.exit_json(**reslt)


if __nme__ == '__min__':
    min()

