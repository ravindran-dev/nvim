import browser_cookie3
import json

try:
    cj = browser_cookie3.chrome(domain_name="leetcode.com")

    cookies = {}
    for c in cj:
        if c.name in ["LEETCODE_SESSION", "csrftoken"]:
            cookies[c.name] = c.value

    if "LEETCODE_SESSION" in cookies and "csrftoken" in cookies:
        print(json.dumps(cookies))
    else:
        print("ERROR: Missing cookies")
except Exception as e:
    print("ERROR:", e)
