context("Parsing messages")

test_that("get_messages parses all messages from a mailbox object", {
  if (!reticulate::py_module_available("mailbox"))
    skip("mailbox not available for testing")

  mb <- mailman:::get_mailbox("data/test_mailbox.mbox", type="mbox")
  messages <- get_messages(mb)

  result <- tibble::tibble(From=c("foo@bar.com", NA, "foo@bar.com"),
                   To=c("spam@eggs.co.uk", "spam@eggs.co.uk",
                        "spam@eggs.co.uk"),
                   Date=c("2018-01-01 12:00", "2018-01-01 12:00",
                          "2018-01-01 12:00"),
                   Body=c("This is a test\n", "This is a second test\n",
                          "This is a fourth test"))
  expect_equal(result, messages)
})


test_that("get_messages returns a warning for an empty mailbox object", {
  if (!reticulate::py_module_available("mailbox"))
    skip("mailbox not available for testing")

  mb <- mailman:::get_mailbox("data/empty_mailbox.mbox", type="mbox")
  expect_warning(get_messages(mb))
})
