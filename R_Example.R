# Load packages -----------------------------------------------------------------------------------------
library(namedCapture)
library(glue)


# Expected file name ------------------------------------------------------------------------------------
fileName <- "123456_CompanyA_20201214_1_1.xml"


# Set up regex pattern ----------------------------------------------------------------------------------
companyCodePattern <- "(?P<CompanyCode>[0-9]{6})"
companyNamePattern <- "(?P<CompanyName>[a-zA-Z]+)"
datePattern <- "(?P<Date>[0-9]{8})"
submissionNumberPattern <- "(?P<SubmissionNumber>[0-9]{1})"
schemaVersionPattern <- "(?P<SchemaVersion>[0-9]{1})"
fileExtensionPattern <- "(?P<FileExtension>[a-zA-Z]+)"

regexPattern <- glue::glue('{companyCodePattern}_{companyNamePattern}_{datePattern}_{submissionNumberPattern}_{schemaVersionPattern}.{fileExtensionPattern}')


# Apply pattern matching --------------------------------------------------------------------------------
regexMatchesMatrix <- namedCapture::str_match_named(subject.vec = fileName, pattern = regexPattern)

regexMatches <- as.list(data.frame(regexMatchesMatrix, stringsAsFactors = FALSE))


# Inspect matches ---------------------------------------------------------------------------------------
str(regexMatches)
# List of 6
# $ CompanyCode     : chr "123456"
# $ CompanyName     : chr "CompanyA"
# $ Date            : chr "20201214"
# $ SubmissionNumber: chr "1"
# $ SchemaVersion   : chr "1"
# $ FileExtension   : chr "xml"


print(regexMatches$Date)
# "20201214"


for (i in seq_along(regexMatches)) {
  matchName <- names(regexMatches)[i]
  matchValue <- regexMatches[[i]]
  print(glue::glue("The {matchName} is {matchValue}"))
}
# The CompanyCode is 123456
# The CompanyName is CompanyA
# The Date is 20201214
# The SubmissionNumber is 1
# The SchemaVersion is 1
# The FileExtension is xml
