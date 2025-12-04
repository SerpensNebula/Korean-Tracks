# Makefile for Korean Tracks project

# Variables
BUILD_DIR = build
NML_FILE = Korean_Tracks.nml
GRF_FILE = $(BUILD_DIR)/Korean_Tracks.grf
ZIP_FILE = $(BUILD_DIR)/Korean_Tracks.tar.gz

# Default target
all: check-tools $(ZIP_FILE)

# Check for required tools
check-tools:
	@which nmlc > /dev/null || (echo "Error: nmlc not found. Please install nmlc to continue."; exit 1)
	@which tar > /dev/null || (echo "Error: tar not found. Please install tar to continue."; exit 1)

# Create build directory
$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

# Compile NML to GRF
$(GRF_FILE): $(NML_FILE) $(BUILD_DIR)
	nmlc ./$(NML_FILE) -o ./$(GRF_FILE)

# Copy NML file to build directory
$(BUILD_DIR)/$(NML_FILE): $(NML_FILE) $(BUILD_DIR)
	cp $(NML_FILE) $(BUILD_DIR)/

# Create tar.gz file with both files
$(ZIP_FILE): $(GRF_FILE) $(BUILD_DIR)/$(NML_FILE)
	cd $(BUILD_DIR) && tar -czf Korean_Tracks.tar.gz Korean_Tracks.grf Korean_Tracks.nml

# Clean build directory
clean:
	rm -rf $(BUILD_DIR)

.PHONY: all clean