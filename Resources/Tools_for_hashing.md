# Tools for hashing values in datasets

## R package

Hashing in R can be performed using the [anonymizer package](https://github.com/paulhendricks/anonymizer).

### Installing anonymizer

```r
devtools::install_github("paulhendricks/anonymizer")
```

### Using anonymizer

The package can be used to hash a dataframe column:

```r
library(anonymizer)

df <- data.frame(name = c("Bob", "Anne", "Judith", "Bob"), age = c(25, 30, 22, 25))

df$name <- anonymize(df$name, .seed = 123)
print(df)
```

This process is uni-directional, so hashed values cannot be decoded. However, setting the seed makes the process deterministic. This means that if I know a subject's name and the seed value, I can find their data in the anonymised table:

```r
bob_hash <- anonymize("Bob", .seed = 123)

print(subset(df, name == bob_hash))
```

## Python

pandas dataframes in python can be hashed using the hashlib library.

### Installing hashlib

```python
pip install hashlib
```

### Using hashlib

```python
def anonymize(value, salt='123'):
    return hashlib.sha256((str(value) + salt).encode('utf-8')).hexdigest()

df = pd.DataFrame({
    'name': ['Bob', 'Anne', 'Judith', 'Bob'],
    'age': [25, 30, 22, 25]
})

df = df.assign(name = lambda x: anonymize(x, salt='123'))
print(df)
```

In this case, the "salt" ensures that the hashing output will always be the same. Similar to R, you can use this to find data for a particular person.

```python
bob_hash = anonymize("Bob", salt='123')
print(df[df['anon_name'] == bob_hash])
```

## Excel

Excel does not come with functions for hashing out-of-the-box. However, we made a custom function to hash values (however, it does not allow using salt). To use it, follow these steps.

- Download [MD5Hash.bas](./MD5Hash.bas)
- In Excel, press `Alt + F11` to open the VBA editor
- In the editor, go to **File** -> **Import File** and select the MD5Hash.bas file
- Close the VBA editor window
- You can now use the `=MD5HASH(XX, "salt")` function to encode cell values, where XX is the cell to be encoded, and "salt" is the salt value (any numbers and letters, with the double-quotes)
