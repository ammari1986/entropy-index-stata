Entropy Index Program for Stata

This repository contains a Stata program (`entropy_index`) that implements the Entropy Method to construct a composite index. The entropy method is widely used in data analysis to assign weights to indicators based on their variability (entropy). This program automates the process of normalization, entropy calculation, weight derivation, and composite index construction.

## Table of Contents
1. [Features](#features)
2. [Installation](#installation)
3. [Usage](#usage)
4. [Example](#example)
5. [Dependencies](#dependencies)
6. [Contributing](#contributing)
7. [License](#license)
8. [Contact](#contact)

---

## Features
- **Normalization**: Automatically normalizes input variables using min-max scaling.
- **Entropy Calculation**: Computes entropy for each variable to measure its variability.
- **Weight Derivation**: Derives weights based on divergence from maximum entropy.
- **Composite Index Construction**: Combines normalized variables into a single composite index.
- **Flexible Input**: Works with any number of numeric variables.

---

## Installation

### Option 1: Manual Installation
1. Download the `entropy_index.ado` file from this repository.
2. Save the file in your Stata personal ado directory:
   - **Windows**: `C:/Users/YourName/Documents/Stata/ado/personal/`
   - **Mac/Linux**: `~/ado/personal/`
3. Restart Stata to load the program.

### Option 2: Install Directly from GitHub
Run the following commands in Stata to install the program directly:
```stata
net install entropy_index, from("https://raw.githubusercontent.com/ammari1986/entropy-index-stata/main")
```

---

## Usage

### Syntax
```stata
entropy_index varlist, generate(newvar)
```

- `varlist`: A list of numeric variables to include in the composite index.
- `generate(newvar)`: The name of the new variable to store the composite index.

### Example Command
```stata
entropy_index X1 X2 X3 X4, generate(composite_index)
```

---

## Example

### Step 1: Load Sample Data
```stata
clear
input X1 X2 X3 X4
10 20 30 40
15 25 35 45
20 30 40 50
25 35 45 55
end
```

### Step 2: Run the Program
```stata
entropy_index X1 X2 X3 X4, generate(composite_index)
```

### Step 3: Check Results
```stata
summarize composite_index
browse
```

---

## Dependencies
- **Stata 14 or later**: The program uses features like `egen`, `foreach`, and `marksample`, which are available in Stata 14+.
- No additional packages are required.

---

## Contributing
Contributions are welcome! If you find a bug or have suggestions for improvement:
1. Open an issue in this repository.
2. Fork the repository, make your changes, and submit a pull request.

---

## License
NA

---

## Contact
If you have questions or need support, feel free to reach out:
- **Author**: Aymen Ammari
- **Email**: ammariaymen@yahoo.com
- **GitHub Profile**: [https://github.com/ammari1986](https://github.com/ammari1986)