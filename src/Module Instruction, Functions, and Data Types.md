# Module Instruction, Functions, and Data Types
<br>

# Instructions

<br>

---

## IO_CONNECT_DI_WITH_MOCK- Define Digital Input Signal and Mock with Alias Name
### Module: CM_IO

### Usage
IO_CONNECT_DI_WITH_MOCK is used to define an IO  digital input signal that is also attached to a digital output signal. The digital output signal serves as a mock when the station is in the virtual condition to allow writing as well as reading. Mocked signals can be used for predefined generic programs, without any modification of the program before running in different robot installations or in virtual controllers with virtual signals. The instruction IO_CONNECT_DI_WITH_MOCK must be run before any use of the actual signal.

Mocked signals are intended for simulating real world signals in virtual environments, but utilizing real signals in the field.

---
### Basic Examples
#### Example 1

---
### Arguments

|Argument|Description|
|-|-|
| **from_signal** | digital input signal <br> Data Type: **signaldi** <br><br> The digital input signal identifier according to the configuration from which the signal descriptor is copied. The signal must be defined in the I/O configuration|
|**from_signal_mock**| digital output signal <br> Data Type: **signaldo** <br><br> The digital output signal identifier according to the configuration from which the signal descriptor is copied. The signal must be defined in the I/O configuration and should not be assigned to any device.|
|**to_signal_alias**| digital input signal with mock <br>Data Type: **IO_signaldi** <br><br> The combined signal according to the program to which the signal descriptors are copied. The signal must be declared in the RAPID program.|


### Program Execution
Program execution
asdsa
asd

---

### Error Handling
| Name| Cause of Error |
|----------|----------|
| ERROR | Cause of error   |

---
### Limitations

---
### Syntax
IO_CONNECT_DI_WITH_MOCK (VAR signaldi from_signal, VAR signaldo from_signal_mock, VAR IO_signaldi to_signal_alias)

---
### Related Information
| For information about| See |
|----------|----------|
|  | [Link Name](#Link)   |

<br>
<br>

---

## IO_CONNECT_AI_WITH_MOCK - Short Description
### Module: CM_IO

### Usage
Usage

---
### Basic Examples
#### Example 1
Example 1

---
### Arguments

|Argument|Description|
|-|-|
| **from_signal** | argument full name <br> Data Type: **signalai** <br><br> Argument Function|
| **from_signal_mock** | argument full name <br> Data Type: **signalao** <br><br> Argument Function|
| **to_signal_alias** | argument full name <br> Data Type: **IO_signalai** <br><br> Argument Function|

### Program Execution
Program Execution

---

### Error Handling
| Name| Cause of Error |
|----------|----------|
| ERROR | Cause of error   |

---
### Limitations
Limitations

---
### Syntax
Syntax

---
### Related Information
| For information about| See |
|----------|----------|
|  | (Link Name](#Link)    |

<br>
<br>