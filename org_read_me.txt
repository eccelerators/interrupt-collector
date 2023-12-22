# InterruptCollector
This block defines a basic interrupt collector for **level triggered** interrupt sources.
Usually edge triggered sources e.g., timers pulse can be converted to level triggered 
ones by catching them in the user logic. 
Its purpose is to be inherited by implementations of e.g., SPI, I2C etc. controllers based on this principle.


In this article, we focussed on an individual IP component rather than a complete
FPGA design. Consequently, instead of creating a bitstream, we employ GHDL for
simulation purposes. Our IP is simulated using the SimStm framework, a tool we
developed for simulation and testing.

To begin with, we utilize the register description to generate various HxS artifacts,
including the VHDL register interface and its documentation. For this process,
we've set up a Linux environment, specifically using Ubuntu 22.04. The first step
involves installing Ant.

    ~$ sudo apt-get install ant -y

Next, we clone the actual `crc-calculator` repository from the [Eccelerators GitHub]
repository:

    ~$ git clone --recurse-submodules git@github.com:eccelerators/crc-calculator.git

Following that, we establish a Python3 virtual environment and install the necessary
dependencies:

    ~$ python3 -m venv .venv
    ~$ source .venv/bin/activate
    ~$ pip3 install -r requirements.txt

With the setup complete, we are now ready to build all the artifacts required for
simulation:

    ~$ make

The HxS files are located in the `hxs` directory. The VHDL files related to the
IP and its simulation are organized within the following directory structure:

src/vhdl This folder contains the primary VHDL source files for the IP.
src-gen/vhdl Here, you'll find generated VHDL files specific to
  the AXI4-Lite interface.
tb/vhdl This directory houses the VHDL files used for testbenching and
  simulation.

Additionally, the documentation for this IP, generated in various formats, is
located in these folders:

src-gen/docbook-pdf Contains the documentation in PDF format.
src-gen/docbook-html  Holds the HTML version of the documentation (Docbook).
src-gen/html-sphinx  Holds the HTML version of the documentation (Sphinx).
src-gen/rst Stores the reStructuredText (rst) files, typically used for
  more textual documentation.

The simulation is executed with the following command:

    ~$ make sim

A successful simulation will yield an output similar to this:

    + ./crccalculatortestbench --stop-time=100000ns
    simstm/src/tb_simstm.vhd:1245:21:@1000300ps:(assertion note): test finished with no errors!!