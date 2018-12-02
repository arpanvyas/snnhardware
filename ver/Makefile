export PROJECT_DIR
export PROJECT_RTL_DIR
export PROJECT_VER_DIR

RTL_DIR=
RTL_FILES=
TB_FILES=
HEADER_FILES=

ifndef TC
	TC=test
endif
ifndef SEED
	SEED=12345
endif
ifndef MODULE
	MODULE=snn
endif
export TC
export SEED
export MODULE



IRUN_OPTS += -access +r -vlog_ext .v,.vh #$(IRUN_PERF_OPTS) 
IRUN_PERF_OPTS += ncelab -delay_mode zero ncsim -mcdump
#IRUN_RTLOPTS += $(IRUN_OPTS) -elaborate
#IRUN_TBOPTS += -elaborate
IRUN_GUIOPTS += -gui 

#LIBRARY NAMES
IRUN_OPTS += -nclibdirpath $$PROJECT_VER_DIR/SNAPSHOTS -nclibdirname INCA_snn 

#SOURCE FILES
#IRUN_RTLOPTS += $(RTL_FILES) $(HEADER_FILES) -incdir $(INCLUDE_DIRS)
IRUN_TBOPTS += $(RTL_FILES) $(TB_FILES) $(HEADER_FILES) -incdir $(INCLUDE_DIRS)
#HEADER FILES
HEADER_FILES += $$PROJECT_VER_DIR/HDL/header.vh
INCLUDE_DIRS += $$PROJECT_RTL_DIR/modules/snn/
INCLUDE_DIRS += -incdir $$PROJECT_VER_DIR/FEED/
INCLUDE_DIRS += -incdir $$PROJECT_VER_DIR/HDL/


#LOG FILES
IRUN_OPTS += -logfile $$PROJECT_VER_DIR/LOGS/irun.log -mccodegen -mcmaxcores 4
#IRUN_RTLOPTS += -log_ncelab $$PROJECT_VER_DIR/LOGS/$(MODULE)_rtl_ncelab.log -log_ncvlog $$PROJECT_VER_DIR/LOGS/$(MODULE)_rtl_ncvlog.log
IRUN_TBOPTS += -log_ncelab $$PROJECT_VER_DIR/LOGS/$(MODULE)_tb_ncelab.log -log_ncvlog $$PROJECT_VER_DIR/LOGS/$(MODULE)_tb_ncvlog.log
IRUN_GUIOPTS += -log_ncsim $$PROJECT_VER_DIR/LOGS/$(TC)_$(SEED)_$(MODULE).log -k $$PROJECT_VER_DIR/LOGS/$(TC)_$(SEED)_$(MODULE).key

#SEEDS
IRUN_GUIOPTS += -seed $(SEED)
#TCL FILES
IRUN_GUIOPTS += -input $$PROJECT_VER_DIR/TCL/force.do

###########################################################
#FOR COMPILING MODULE
###########################################################

#SOURCE
RTL_FILES += $$PROJECT_RTL_DIR/modules/snn/*
TB_FILES += $$PROJECT_VER_DIR/HDL/tb.v

#WORKDIR and SNAPSHOTS
#IRUN_TBOPTS += -snapshot snnsnap
#IRUN_GUIOPTS += -r snnsnap

#ADDITIONAL FORCS
IRUN_GUIOPTS += -input $$PROJECT_VER_DIR/TCL/force_snn.do

###########################################################
#TARGETS
###########################################################

clean:
	rm -rf $$PROJECT_VER_DIR/SNAPSHOTS/*
#rtl:
#	irun $(IRUN_RTLOPTS)
tb:
	irun $(IRUN_OPTS) -elaborate $(IRUN_TBOPTS) -snapshot snnsnap 
run:
	irun $(IRUN_OPTS) $(IRUN_GUIOPTS) -r snnsnap
all:
	irun $(IRUN_OPTS) $(IRUN_TBOPTS) $(IRUN_GUIOPTS)

profile:
	irun -iprof $(RTL_FILES) $(TB_FILES) $(HEADER_FILES) -incdir $(INCLUDE_DIRS) -vlog_ext .v,.vh 
