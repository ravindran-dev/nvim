local browser = require("core.leetcode_browser").get_cookie()

require("leetcode").setup({
  arg = "leetcode",
  lang = "python3",
  injector = {
    leetcode = browser and {
      cookies = {
        ["LEETCODE_SESSION"] = browser.LEETCODE_SESSION,
        ["csrftoken"] = browser.csrftoken,
      }
    } or nil,
  }
})
