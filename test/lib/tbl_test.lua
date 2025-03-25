require('busted.runner')()

local tbl = require("lib/tbl")

local hasKeyTest = function()
  local t = {"some value", key = "another value"}

  it(
    "returns true if given key is present in table",
    function()
      assert.is_true(tbl.hasKey(t, "key"))
      assert.is_true(tbl.hasKey(t, 1))
    end
  )

  it(
    "returns false if key is not present in table",
    function()
      assert.is_false(tbl.hasKey(t, "key2"))
      assert.is_false(tbl.hasKey(t, 2))
    end
  )
end

local valuesTest = function()
  local t = {
    "some value at index 1",
    "some value at index 2",
    key = "another value",
    key2 = "yet another value"
  }

  it(
    "returns all values in table in alphabetical order when no key is given",
    function()
      local expectation = {
        "another value",
        "some value at index 1",
        "some value at index 2",
        "yet another value"
      }

      assert.is.same(expectation, tbl.sort(tbl.values(t)))
    end
  )

  it(
    "returns only values whose keys match the ones given in alphabetical order",
    function()
      local expectation = {"another value", "some value at index 1", "yet another value"}
      assert.is.same(expectation, tbl.sort(tbl.values(t, {"key2", 1, "key"})))
    end
  )
end

local digTest = function()
  local t = {
    "some value at index 1",
    key = "another value",
    key2 = {
      nestedKey = {
        "yet another value",
        deepNestedKey = "last value"
      }
    }
  }

  it(
    "returns a table value following the path of existing keys",
    function()
      assert.is.same("some value at index 1", tbl.dig(t, 1))
      assert.is.same("another value", tbl.dig(t, "key"))
      assert.is.same(t.key2, tbl.dig(t, "key2"))
      assert.is.same(t.key2.nestedKey, tbl.dig(t, "key2", "nestedKey"))
      assert.is.same("yet another value", tbl.dig(t, "key2", "nestedKey", 1))
      assert.is.same("last value", tbl.dig(t, "key2", "nestedKey", 1, "deepNestedKey"))
    end
  )

  it(
    "returns nil if given an invalid path of keys",
    function()
      assert.is_nil(tbl.dig(t, 2))
      assert.is_nil(tbl.dig(t, "key3"))
      assert.is_nil(tbl.dig(t, "key", "nestedKey"))
    end
  )
end

local tblTest = function()
  describe(".hasKey", hasKeyTest)
  describe(".values", valuesTest)
  describe(".dig", valuesTest)
end

describe("tbl module", tblTest)
