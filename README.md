# ✅ UVM Verification of SPI Core (Wishbone Compatible)

This project focuses on building a **Universal Verification Methodology (UVM)** testbench for a **Wishbone-compatible SPI Core**. It verifies core functionalities including register reset behavior, protocol-level read/write, buffer overflow, and flag signaling.  

🧪 The verification is based on **directed** and **randomized test cases**, along with **functional coverage** and **scoreboard checking**.

---

## 🧠 Overview

- **Design Under Test (DUT):** SPI Core with Wishbone bus interface
- **Verification Methodology:** UVM (SystemVerilog)
- **Verification Scope:** Reset, buffer handling, protocol integrity, flag logic

---

## 📜 Project Structure

```plaintext
uvm_spi_verification/
├── rtl/                   # SPI Core RTL files
├── tb/                    # UVM testbench components
│   ├── spi_env/           # Environment, agents, sequences
│   ├── test_lib/          # Tests and stimulus generation
│   └── scoreboard.sv      # Scoreboard logic
├── scripts/               # Run scripts (e.g., xrun, vcs)
├── file.f                 # File list for compilation
└── README.md              # This document
````

---

## 🧪 Test Plan Overview

| Test ID | Test Name                    | Objective                                                     | Expected Outcome     |
| ------: | ---------------------------- | ------------------------------------------------------------- | -------------------- |
|     TC1 | Reset Test                   | Verify correct reset values in control and status registers   | All registers reset  |
|     TC2 | Read/Write Between Protocols | Confirm correct read/write transactions over SPI and Wishbone | Data matches         |
|     TC3 | Write Buffer Full            | Check behavior when write buffer overflows                    | Overflow flag raised |
|     TC4 | Write Buffer Collision       | Detect simultaneous write attempts to full buffer             | Collision detected   |
|     TC5 | Read Buffer Full             | Validate full flag when read FIFO overflows                   | Full flag asserted   |

Each test is implemented as a separate UVM test case with predictable stimulus and coverage goals.

---

## 🧪 How to Run the Verification

| Step | Action                                                                                            |
| ---- | ------------------------------------------------------------------------------------------------- |
| 1.   | **Set Test Parameters** (depth, width, test case) inside testbench or config object               |
| 2.   | **Select Test Case** (e.g., `test = 1` for Reset Test, `test = 4` for Full Flag)                  |
| 3.   | **Compile & Run** the simulation:<br> `xrun -f file.f -sv +UVM_TESTNAME=test_full_flag`           |
| 4.   | **Check Scoreboard/Logs** for pass/fail                                                           |
| 5.   | **Verify Coverage** (especially for random tests):<br> Check functional and code coverage reports |

---

## 🧬 DUT Register Model

A simple DUT register model is used to:

* Reflect and track register values during test execution
* Map test sequences to DUT address map
* Log and debug control/status interaction

---

## ✅ Sample Test Results (Waveform Analysis)

### TC1 - Reset Test

* **Waveform confirms** all control/status registers zeroed after asynchronous reset.
* **Status:** ✅ Passed

### TC2 - Cross-Protocol Read/Write

* SPI master successfully reads data written by Wishbone master and vice versa.
* **Status:** ✅ Passed

### TC3/TC4 - Write Buffer Full & Collision

* Write attempts beyond buffer depth correctly trigger full/collision flags.
* **Status:** ✅ Passed (with expected errors logged)

### TC5 - Read Buffer Full

* FIFO full flag asserts correctly, write pointer stops incrementing.
* **Status:** ✅ Passed

> Note: Error tests are **intentional** to confirm robustness under stress and edge conditions.

---

## 📈 Functional Coverage

* **Scoreboard** used to track expected vs actual data
* **Coverage model** tracks:

  * Buffer states (empty, full, overflow)
  * Read/write transaction types
  * Protocol interlock behavior
* Coverage reports generated for **test7 (random test)** to ensure corner cases are hit

---

## 🔚 Conclusion

* Successfully verified all **functional features** of a Wishbone-compatible SPI core
* Developed a **modular UVM environment** with register modeling, agents, scoreboard, and coverage
* Detected and handled edge conditions including buffer overflows and protocol mismatches

---

## 📚 References

* IEEE 1800.2 (UVM Standard)
* Wishbone Bus Specification
* SPI Protocol Specification
* Mentor Graphics UVM Cookbook
* \[RISC-V Wishbone Integration Docs] (if applicable)

---

## 👨‍💻 Author

**Ahmad Mukhtar**

