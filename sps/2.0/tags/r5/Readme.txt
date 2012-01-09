******************************************
SPS 2.0 Executable Test Suite (ETS) Notes: 
******************************************

The items below are important notes to consider regarding this SPS test suite.  More details on specific tests can be found in the SPS Abstract Test Suite (ATS).

***********************
What IS Tested/Handled:
***********************

- All required aspects of the mandatory operations of the SPS:  
	BasicSensorPlanner interfaces 	: GetCapabilities, DescribeTasking, Submit, GetStatus, GetTask, DescribeResultAccess
	SensorProvider interfaces   	: DescribeSensor

- Valid exception reporting according to the specification

- The Capabilities document lists all of the mandatory operations of the SPS specification

- Any non-mandatory operations listed have valid SPS operation names

***************************
What IS NOT Tested/Handled:
***************************

- Optional operations of the SPS:
	ReservationManager interface 	:	Reserve, Confirm, 
	FeasibilityController interface	:	GetFeasibility
	TaskUpdater interface			:	Update
	TaskCanceller interface			:	Cancel
	SensorDescriptionManager interface:	UpdateSensorDescription
