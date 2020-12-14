# Load packages -----------------------------------------------------------------------------------------
import re


# Expected file name ------------------------------------------------------------------------------------
fileName = "123456_CompanyA_20201214_1_1.xml"


# Set up regex pattern ----------------------------------------------------------------------------------
companyCodePattern = "(?P<CompanyCode>[0-9]{6})"
companyNamePattern = "(?P<CompanyName>[a-zA-Z]+)"
datePattern = "(?P<Date>[0-9]{8})"
submissionNumberPattern = "(?P<SubmissionNumber>[0-9]{1})"
schemaVersionPattern = "(?P<SchemaVersion>[0-9]{1})"
fileExtensionPattern = "(?P<FileExtension>[a-zA-Z]+)"

regexPattern = rf'{companyCodePattern}_{companyNamePattern}_{datePattern}_{submissionNumberPattern}_{schemaVersionPattern}.{fileExtensionPattern}'


# Apply pattern matching --------------------------------------------------------------------------------
compiledRegexPattern = re.compile(pattern = regexPattern)

regexSearch = compiledRegexPattern.search(string = fileName)

regexMatches = regexSearch.groupdict()


# Inspect matches ---------------------------------------------------------------------------------------
print(regexMatches)
# {'CompanyCode': '123456', 'CompanyName': 'CompanyA', 'Date': '20201214', 'SubmissionNumber': '1', 'SchemaVersion': '1', 'FileExtension': 'xml'}


print(regexMatches["Date"])
# 20201214

for match in regexMatches:
    print(f'The {match} is {regexMatches[match]}')
# The CompanyCode is 123456
# The CompanyName is CompanyA
# The Date is 20201214
# The SubmissionNumber is 1
# The SchemaVersion is 1
# The FileExtension is xml
