# Personal experimental project

The overleaf of our research proposal is given here:

https://www.overleaf.com/6656833847pfhgcxrjjpws

If you need more informations about how to do some "mise en page", read the following paper:

https://www.overleaf.com/read/sbtpnpxpvcpt

The link to our google drive is the following:

https://drive.google.com/drive/folders/17XrhKB2nTQqwcYZuHuUrv0lbRzzoZMON?usp=sharing

## Organisation of experiment folder

- Initial :
    - Background : It must contains the background image taken during our experiment and must be named "Background.jpg"
    - Data       : Contains the data obtained by running the "Balance script". This data is considered as "raw" since it only contains the mass and time 
    - Photos     : Contains all the frames obtained by running the script "Video_Processing" on the videos of our experiments
    - Videos     : Videos of our experiements !

- '____' : You do not have to look into that folder

- Final  :
    - Data   : Contains the data obtained after running the script "Image_Analysis". The data contained the mass, alpha and stifness (low, mean, high)
    - Photos : Contains the images processes by "Image_Processing" which will be used by "Image_analysis" to compute alpha and the stiffness.

## Matlab code

- Code in the main folder :
    - Balance : This script is runned during our experiments ! It measures and save the time and balance measurement !
    - Video_Processing : Transform the video into frames which are taken at the different times saved in the data files
    - Image_Processing : Process all the images inside the folder "Experiment/Initial/Photos/"
    - Image_Analysis   : Compute all the angles and stifness relative to the photos inside the "Experiment/Final/Photos/" folder. 

- Code in the "Function" folder : this contains only small functions and piece of codes, thus, if there is no bug, one should not have to look into it !

Note :
 - A script begin with an upper case letter whereas functions begin with a lowercase letter
 - The script balance should be terminated before the end of the recording to make sure that the time vector corresponds well to the video ! 
 - At the begginnig of each script, one can change some script parameters or processing parameters ! Feel free to try them !
