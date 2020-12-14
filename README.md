# Regex Named Capture Groups
Examples of using capture groups in R and Python to easily:

- Validate a string against an expected pattern, and:

- Extract multiple parts of that string into a structured object


## Named groups
A regex pattern can be split into multiple groups that each have an associated name.

The basic template for creating a named group is:

- "(?P\<GroupName\>....regex...pattern...here...)"

Multiple groups can also be chained together:

- "(?P\<FirstGroupName\>...first...pattern)(?P\<SecondGroupName\>...second...pattern)"

The names given to groups are important as they are referenced later in the process.


## Example scenario
In the below examples, we assume file names follow specific convention and attempt to extract 
information from them, such as what company name or date the file relates to.

The benefit of using named capture groups in this case (as opposed to splitting the file name by underscores _),
is greater accuracy since the resulting regex pattern is used to both validate the string and extract information from it.


## Example in R
```R
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

```


## Example in Python
```python
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

```
