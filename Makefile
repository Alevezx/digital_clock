
VHDLDIR=VHDL
WORKDIR=WORK
VCDDIR=VCD
MAIN=testBench
TIME="3600ns"

GHDL=ghdl
GHDLFLAGS=--ieee=synopsys --std=08
GHDLRUNFLAGS=--vcd=$(MAIN).vcd --stop-time=$(TIME)

all: run

run: elaboration
	$(GHDL) -c $(GHDLFLAGS) -r $(MAIN) $(GHDLRUNFLAGS)
	mv $(MAIN).vcd $(VCDDIR)
	mv *.cf $(WORKDIR)

elaboration: analysis
	$(GHDL) -c $(GHDLFLAGS) -e $(MAIN)

analysis: clean
	$(GHDL) -a $(GHDLFLAGS) $(VHDLDIR)/digital_clock.vhd
	$(GHDL) -a $(GHDLFLAGS) $(VHDLDIR)/clock_counter.vhd
	$(GHDL) -a $(GHDLFLAGS) $(VHDLDIR)/LED_display.vhd
	$(GHDL) -a $(GHDLFLAGS) $(VHDLDIR)/clock_generator.vhd
	$(GHDL) -a $(GHDLFLAGS) $(VHDLDIR)/$(MAIN).vhd

clean: force
	@rm -f $(WORKDIR)/* $(VCDDIR)/* *.cf *.vcd

force: