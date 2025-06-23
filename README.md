# 🗄️ Custom Data Hub

[![Issues](https://img.shields.io/github/issues/Skorpion02/Base_de_datos_personalizada?style=flat-square)](https://github.com/Skorpion02/Base_de_datos_personalizada/issues)
[![Forks](https://img.shields.io/github/forks/Skorpion02/Base_de_datos_personalizada?style=flat-square)](https://github.com/Skorpion02/Base_de_datos_personalizada/network/members)
[![Stars](https://img.shields.io/github/stars/Skorpion02/Base_de_datos_personalizada?style=flat-square)](https://github.com/Skorpion02/Base_de_datos_personalizada/stargazers)
[![Last Commit](https://img.shields.io/github/last-commit/Skorpion02/Base_de_datos_personalizada?style=flat-square)](https://github.com/Skorpion02/Base_de_datos_personalizada/commits/main)
[![License](https://img.shields.io/github/license/Skorpion02/Base_de_datos_personalizada?style=flat-square)](LICENSE)
[![SQL](https://img.shields.io/badge/SQL-Oracle-blue?style=flat-square&logo=oracle)](#)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen?style=flat-square&logo=github)](https://github.com/Skorpion02/Base_de_datos_personalizada/pulls)

---

> **A robust Oracle SQL/PLSQL project with anonymous blocks, procedures, functions, triggers, and audit logic. Model complex business rules and ensure data validation & historical tracking.**

---

## 📚 Project Overview

- **Goal:** Implement a custom Oracle database with business logic, validations, exception handling, triggers, and audit trails.
- **Stack:** Oracle SQL & PL/SQL

---

## 🏗️ Main Features

- **Full Schema Setup:** [Configuracion Inicial.sql](./Configuracion%20Inicial.sql) for table and data definition
- **Business Logic:**
  - **Anonymous Blocks:** Multiplication table, IRPF (tax) calculation, record queries and tests.
  - **Procedures:**
    - `SUMA_IMPARES`: Sum all odd numbers up to an integer.
    - `IRPF_EMPLEADO`: Given an employee number, shows name, surname, annual salary, IRPF bracket & percentage. Handles "employee not found" error.
  - **Functions:**
    - `NUMERO_MAYOR`: Returns the largest of three numbers, with error on duplicates.
    - `EMPLEADOS_TRAMOS_IRPF`: Returns the number of employees in a given IRPF bracket.
  - **Triggers:**
    - `COMPENSA_TRAMO_IRPF`: On salary update, if IRPF bracket increases, add €1,000 compensation automatically.
    - `MODIFICACIONES_SALARIOS`: On salary change, adds entry to `AUDITA_SALARIOS` audit table with employee, date, time, old/new salary, and user.
- **Comprehensive Test Blocks:** Anonymous PL/SQL blocks to test every logic piece and show sample outputs.

---

## 📄 Example Features & Expected Outputs

- **Multiplication Table Block:**  
  Prints multiplication table for a chosen number, from 1 to 11.  
  _Example:_  
  ```
  5 x 1 = 5  
  ...  
  5 x 11 = 55
  ```

- **Salary and IRPF Block:**  
  Given a monthly salary, computes annual salary, finds IRPF bracket and percentage, and shows total IRPF due.  
  _Example:_  
  ```
  Salario mensual: 1000 €
  Salario anual: 12000 €
  IRPF aplicado: 19%
  IRPF a pagar: 2280 €
  ```

- **Procedure `SUMA_IMPARES`:**  
  _Input:_ 6  
  _Output_: "El resultado de sumar los impares hasta 6 es: 9"

- **Function `NUMERO_MAYOR`:**  
  _Input:_ (23, 37, 32)  
  _Output_: "El mayor entre (23, 37, 32) es: 37"  
  _(Returns error if any two numbers are equal)_

- **Procedure `IRPF_EMPLEADO`:**  
  _Input:_ Employee #1  
  _Output_: "Antonio García Melero, con salario de 25000 € en tramo 3, con IRPF de un 30%"

- **Function `EMPLEADOS_TRAMOS_IRPF`:**  
  _Input:_ Bracket 5  
  _Output_: "En el tramo 5 de IRPF, tenemos a 2 empleados."

- **Salary Update & Audit Test:**  
  Update salary for an employee and verify that both triggers (`COMPENSA_TRAMO_IRPF`, `MODIFICACIONES_SALARIOS`) work and audit trail is written.

---

## 🗂️ Repository Structure

```
Base_de_datos_personalizada/
├── Configuracion Inicial.sql     # Tables and initial data
├── Estructura.sql               # Procedures, functions, triggers, test blocks
├── README.md
```

---

## 🚀 How to Use

1. **Initialize the Database**
   - Run `Configuracion Inicial.sql` in your Oracle SQL environment to create tables and populate sample data.

2. **Add Business Logic**
   - Run `Estructura.sql` to create all procedures, functions, triggers, and test blocks.

3. **Test Features**
   - Execute the anonymous blocks at the end of `Estructura.sql` to see example outputs and verify correctness.

---

## 🤝 Contributing

Contributions, improvements, and feature requests are welcome!

- Check [issues](https://github.com/Skorpion02/Base_de_datos_personalizada/issues)
- Open a [pull request](https://github.com/Skorpion02/Base_de_datos_personalizada/pulls)
- ⭐ Star this repo if you find it useful!

---

## 📬 Contact

- **Author:** [Skorpion02](https://github.com/Skorpion02)
- **Repository:** [Base_de_datos_personalizada](https://github.com/Skorpion02/Base_de_datos_personalizada)

---

## 📝 License

This project is licensed under the [MIT License](LICENSE).

---

⭐️ **If you found this project helpful, please give it a star!**

---

<div align="center">
  <b>Made with ❤️ by Skorpion02</b>
</div>
