# dl_autism

Autism Deep Learning Matlab Project

The provided matlab scripts will construct a two-stage prediction pipeline that can be used to determine if children (before the age of 2 years old) is at risk for autism. 

To execute the scripts first download the source, unzip it, and then open the Matlab enviroment. In the Matlab environment navigate to the folder that has the scripts (i.e. the folder you unziped), then execute the following Matlab command:

addpath( genpath( pwd ) );

This will add all the required folders (and subfolders) to your Matlab path. To execute the pipeline simply execute the following Matlab command:

run_pipleline( opts );

An example opts structure has also been provided, to load the structure execute the Matlab command:

load opts;

Please Note: For grant purposes, real training and test data (longitudinal cortical surface area, cortical thickness, and intracranial volume (ICV)) are not provided. If you wish to obtain the study data please contact Martin Styner (styner@cs.unc.edu). 

Thank you!

