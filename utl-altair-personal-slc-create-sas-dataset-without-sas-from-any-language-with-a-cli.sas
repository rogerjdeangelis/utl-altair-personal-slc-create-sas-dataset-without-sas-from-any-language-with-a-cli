%let pgm=utl-altair-personal-slc-create-sas-dataset-without-sas-from-any-language-with-a-cli;

%stop_submission;

Altair personal slc create sas dataset without sas from any language with a cli (R PYTHON...)

Too lon
https://github.com/rogerjdeangelis/utl-altair-personal-slc-create-sas-dataset-without-sas-from-any-language-with-a-cli

This is a proof of concept, more work needs to be done to make this 'production'.

This has many applications?

The objective was to create a silent altair personal slc process that can create sas datasets
from other languages like  SPSS. PSPP, MATLAB, OCTAVE, EXCEL ....

This makes all of altair personal analytics available to the larger programming community.

PROBLEM (CONVERT R IRIS DATAFRAME TO IRIS_DF.SAS7BDAT)

 USAGE R Code) (only use metadatabest form an R or powershell program)
 =====================================================================

  R WAIT WAIT WAIT THE R CODE CAN TAKE UP TO 30 SECONDS

  data(iris)
  saveRDS(iris, file = "d:/rds/iris.rds")
  output <- run_powershell_script()
  print(output)

  OUTPUT
    d:/sd1/iris_df.sas7bdat

  LOG
  [1] "Process terminated successfully."


 PART OF THE PREP

  # open up the sas universal viewer snd click on
    d:/sd1/iris_df.sas7bdat.

  Note: the r function

    1 opens up the personal slc
      processes the autoexec file which executes

      options noerrorabend;

      libname sd1 sas7bdat "d:/sd1";

      options set=RHOME "D:\d451";

      proc datasets lib=sd1 nodetails nolist;
       delete want;
       run;quit;

      proc r;
      submit;
         load(
      submit;
      endsubmit;
      import data=sd1.iris r=iris;
      run;quit;

      data _null_;
        file "c:/temp/done.txt";
        put "done";
      run;

      data _null_;
        file "c:/temp/done.txt";
        put "done";
      run;

     output <- run_powershell_script()
   print(output)
   [1] "Process terminated successfully."


CAVEATS

   1 The altair slc soes not seem to support nosplash, key processing seems to goes on inside the splash code?

   2 The personal slc does not support a cli. Better solutions are avilable with academic
     or commecial slc.

   3 Only
     You don't have to select the metadatabest, should work with your metadata.
     I have included my metadatbest
     I haven't noticed any deamons but
     if a deamon Altair task exists in task manager, after you run you should end the task.

   4 This is not a general solution, it is an iris sas dataset solution.


STEPS

  1  SAVE my .metadatabest file where you saved your metadata

     Backup your meta data and zip it.
     It is important to have a zip copy, because,
     if you accidentially select your original metadata file
     eclipse may correupt it and there is no easy wany to undue the corruption.

     Epf file is also in theis repo d:/wpsa/metahope.epf (in this repor)

  5 Set preference to ask for a specific metadata file when launching eclipse

     preferences>(type workspace in search box)
        windows>check Prompt for workspace on startup
     click on my metadata file

     This step is not needed, if you trust eclipse always get the right metadata?

  5 Add the following to your altairslc,cfg

    -AUTOEXEC 'C:\wpsoto\autoexec.sas'

  6 Create Input r dataframe RDS transport file

    %utlfkil(d:/rds/iris.rds)

    options set=RHOME "D:\d451";
    proc r;
    submit;
      data(iris)
      saveRDS(iris, file = "d:/rds/iris.rds")
    endsubmit;
    run;quit;


  7 Place this code in your autoexec.sas. The  ';;;;' helps fix slc bug?

    ;;;;

    %let _init_= %str(
    /* filename wpswbhtm clear; */
    ods _all_ close;
    ods listing;
    options ls=255 ps=65
     nofmterr nocenter
     nodate nonumber
     noquotelenmax
     validvarname=upcase
     compress=no
     FORMCHAR='|----|+|---+=|-/\<>*')
    ;

    options noerrorabend;

    libname sd1 sas7bdat "d:/sd1";

    options set=RHOME "D:\d451";

    proc datasets lib=sd1 nodetails nolist;
     delete want;
     run;quit;

    options set=RHOME "D:\d451";
    proc r;
    submit;
      iris<- readRDS("d:/rds/iris.rds")
    endsubmit;
    import data=sd1.iris_df r=iris;
    run;quit;

    data _null_;
      file "c:/temp/done.txt";
      put "done";
    run;

    /*--- protection for proc r error ---*/
    data _null_;
      file "c:/temp/done.txt";
      put "done";
    run;

  8 run r script from the r gui

   run_powershell_script <- function() {
     # Define the PowerShell script as a string
     ps_script <- '
     Remove-Item -Path "C:\\temp\\done.txt" -ErrorAction SilentlyContinue

     Start-Process "C:\\Program Files\\Altair\\Analytics Workbench\\2025\\eclipse\\workbench.exe"

     # Wait until c:/temp/done.txt exists
     while (-not (Test-Path -Path "C:/temp/done.txt" -PathType Leaf)) {
         Start-Sleep -Seconds 1
     }

     # Kill specific Altair Workbench process by path and task name
     $processPath = "C:\\Program Files\\Altair\\Analytics Workbench\\2025\\eclipse\\workbench.exe"
     $taskName = "workbench"

     # Get matching processes by name
     $targetProcesses = Get-Process -Name $taskName -ErrorAction SilentlyContinue | Where-Object {
         $_.Path -eq $processPath
     }

     # If found, stop them
     if ($targetProcesses) {
         $targetProcesses | Stop-Process -Force
         Write-Output "Process terminated successfully."
     } else {
         Write-Output "No matching process found."
     }
     '

     # Execute the PowerShell script
     result <- system2(
       "powershell",
       args = c("-ExecutionPolicy", "Bypass", "-Command", shQuote(ps_script)),
       stdout = TRUE,
       stderr = TRUE,
       wait = FALSE  # Run asynchronously
     )

   return(result)
   }

   output <- run_powershell_script()
   print(output)


 9  You can run directly from powershell

    Remove-Item -Path C:\temp\done.txt

    Start-Process "C:\Program Files\Altair\Analytics Workbench\2025\eclipse\workbench.exe"

    # Wait until c:/temp/dne.txt exists
    while (-not (Test-Path -Path "C:/temp/done.txt" -PathType Leaf)) {
        Start-Sleep -Seconds 1
    }

    Stop-Process -Name "workbench" -Force

    # Kill specific Altair Workbench process by path and task name

    $processPath = "C:\Program Files\Altair\Analytics Workbench\2025\eclipse\workbench.exe"
    $taskName = "workbench"

    # Get matching processes by name
    $targetProcesses = Get-Process -Name $taskName -ErrorAction SilentlyContinue | Where-Object {
        $_.Path -eq $processPath
    }


    # If found, stop them
    if ($targetProcesses) {
        $targetProcesses | Stop-Process -Force
        Write-Output "Process(es) '$taskName' from path '$processPath' have been terminated."
    } else {
        Write-Output "No matching process found for '$taskName' at '$processPath'."
    }

  9 Select metadata

 10 WAIT WAIT WAIT (20-30 seconds)
    Seems to be a lot of baggage, much less with a CLI?
    a  local server started
    b  you should see the auexec log for a second. Then it closes.

 11 Test the sas dataset in d:/sd1/iris_df.sas7bdat

    a using r haven package to check, see below

    b opening in the sas viewer.
    c using altair personal slc export.

/*                   _
(_)_ __  _ __  _   _| |_
| | `_ \| `_ \| | | | __|
| | | | | |_) | |_| | |_
|_|_| |_| .__/ \__,_|\__|
        |_|
*/

%utlfkil(d:/rds/iris.rds)

options set=RHOME "D:\d451";
proc r;
submit;
  data(iris)
  saveRDS(iris, file = "d:/rds/iris.rds")
endsubmit;
run;quit;

/*
| | ___   __ _
| |/ _ \ / _` |
| | (_) | (_| |
|_|\___/ \__, |
         |___/
*/


202       ODS _ALL_ CLOSE;
203       FILENAME WPSWBHTM TEMP;
NOTE: Writing HTML(WBHTML) BODY file d:\wpswrk\_TD21752\#LN00012
204       ODS HTML(ID=WBHTML) BODY=WPSWBHTM GPATH="d:\wpswrk\_TD21752";
205       %utlfkil(d:/rds/iris.rds)
206
207       options set=RHOME "D:\d451";
208       proc r;
209       submit;
210         data(iris)
211         saveRDS(iris, file = "d:/rds/iris.rds")
212       endsubmit;
NOTE: Using R version 4.5.1 (2025-06-13 ucrt) from d:\r451

NOTE: Submitting statements to R:

>   data(iris)

NOTE: Processing of R statements complete

>   saveRDS(iris, file = "d:/rds/iris.rds")
213       run;quit;
NOTE: Procedure r step took :
      real time : 0.338
      cpu time  : 0.031


214       quit; run;
215       ODS _ALL_ CLOSE;
216       FILENAME WPSWBHTM CLEAR;

/*
 _ __   _ __  _ __ ___   ___ ___  ___ ___
| `__| | `_ \| `__/ _ \ / __/ _ \/ __/ __|
| |    | |_) | | | (_) | (_|  __/\__ \__ \
|_|    | .__/|_|  \___/ \___\___||___/___/
       |_|
Paste this into an r gui
*/

run_powershell_script <- function() {
  # Define the PowerShell script as a string
  ps_script <- '
  Remove-Item -Path "C:\\temp\\done.txt" -ErrorAction SilentlyContinue

  Start-Process "C:\\Program Files\\Altair\\Analytics Workbench\\2025\\eclipse\\workbench.exe"

  # Wait until c:/temp/done.txt exists
  while (-not (Test-Path -Path "C:/temp/done.txt" -PathType Leaf)) {
      Start-Sleep -Seconds 1
  }

  # Kill specific Altair Workbench process by path and task name
  $processPath = "C:\\Program Files\\Altair\\Analytics Workbench\\2025\\eclipse\\workbench.exe"
  $taskName = "workbench"

  # Get matching processes by name
  $targetProcesses = Get-Process -Name $taskName -ErrorAction SilentlyContinue | Where-Object {
      $_.Path -eq $processPath
  }

  # If found, stop them
  if ($targetProcesses) {
      $targetProcesses | Stop-Process -Force
      Write-Output "Process terminated successfully."
  } else {
      Write-Output "No matching process found."
  }
  '

  # Execute the PowerShell script
  result <- system2(
    "powershell",
    args = c("-ExecutionPolicy", "Bypass", "-Command", shQuote(ps_script)),
    stdout = TRUE,
    stderr = TRUE,
    wait = FALSE  # Run asynchronously
  )

return(result)
}

output <- run_powershell_script()
print(output)

/*           _
  __ _ _   _| |_ ___   _____  _____  ___   _ __  _ __ ___   ___ ___  ___ ___
 / _` | | | | __/ _ \ / _ \ \/ / _ \/ __| | `_ \| `__/ _ \ / __/ _ \/ __/ __|
| (_| | |_| | || (_) |  __/>  <  __/ (__  | |_) | | | (_) | (_|  __/\__ \__ \
 \__,_|\__,_|\__\___/ \___/_/\_\___|\___| | .__/|_|  \___/ \___\___||___/___/
                                          |_|
Convert r rds file to sas dataset
*/

;;;;

run;quit;

%let _init_= %str(
ods _all_ close;
ods listing;
options ls=255 ps=65
 nofmterr nocenter
 nodate nonumber
 noquotelenmax
 validvarname=upcase
 compress=no
 FORMCHAR='|----|+|---+=|-/\<>*')
;

%put &_init_;

options noerrorabend;

libname sd1 sas7bdat "d:/sd1";

options set=RHOME "D:\d451";

proc datasets lib=sd1 nodetails nolist;
 delete iris_df;
 run;quit;

options set=RHOME "D:\d451";
proc r;
submit;
  iris<- readRDS("d:/rds/iris.rds")
endsubmit;
import data=sd1.iris_df r=iris;
run;quit;

data _null_;
  file "c:/temp/done.txt";
  put "done";
run;

/*--- protection for proc r error ---*/
data _null_;
  file "c:/temp/done.txt";
  put "done";
run;

/*
| | ___   __ _
| |/ _ \ / _` |
| | (_) | (_| |
|_|\___/ \__, |
         |___/

There is a minor issue with no unicode, autoexec line one is invalid
1       +  ï»¿
*/


NOTE: Copyright 2002-2025 World Programming, an Altair Company
NOTE: Altair SLC 2025 - Community Edition (05.25.01.00.001401)
      License: Altair Trial; expiry: 2026-09-30 17:21
NOTE: This session is executing on the X64_WIN11PRO platform and is running in 64 bit mode

NOTE: AUTOEXEC processing beginning; file is C:\wpsoto\autoexec.sas
NOTE: AUTOEXEC source line

1       +  ï»¿;;;;
           ^
ERROR: Expected a statement keyword : found "ï"

 ods _all_ close; ods listing; options ls=255 ps=65  nofmterr nocenter  nodate nonumber
noquotelenmax  validvarname=upcase  compress=no  FORMCHAR='|----|+|---+=|-/\<>*'

NOTE: Library sd1 assigned as follows:
      Engine:        SAS7BDAT
      Physical Name: d:\sd1

NOTE: Deleting "SD1.IRIS_DF" (memtype="DATA")
NOTE: Procedure datasets step took :
      real time : 0.001
      cpu time  : 0.000


NOTE: Using R version 4.5.1 (2025-06-13 ucrt) from d:\r451

NOTE: Submitting statements to R:


NOTE: Processing of R statements complete

NOTE: Creating data set 'SD1.iris_df' from R data frame 'iris'
NOTE: Column names modified during import of 'iris'
NOTE: Data set "SD1.iris_df" has 150 observation(s) and 5 variable(s)

NOTE: Procedure r step took :
      real time : 0.282
      cpu time  : 0.000



NOTE: The file 'c:\temp\done.txt' is:
      Filename='c:\temp\done.txt',
      Owner Name=T7610\Roger,
      File size (bytes)=0,
      Create Time=14:04:20 Oct 24 2025,
      Last Accessed=14:11:31 Oct 24 2025,
      Last Modified=14:11:31 Oct 24 2025,
      Lrecl=32767, Recfm=V

NOTE: 1 record was written to file 'c:\temp\done.txt'
      The minimum record length was 4
      The maximum record length was 4
NOTE: The data step took :
      real time : 0.004
      cpu time  : 0.000



NOTE: The file 'c:\temp\done.txt' is:
      Filename='c:\temp\done.txt',
      Owner Name=T7610\Roger,
      File size (bytes)=0,
      Create Time=14:04:20 Oct 24 2025,
      Last Accessed=14:11:31 Oct 24 2025,
      Last Modified=14:11:31 Oct 24 2025,
      Lrecl=32767, Recfm=V

NOTE: 1 record was written to file 'c:\temp\done.txt'
      The minimum record length was 4
      The maximum record length was 4
NOTE: The data step took :
      real time : 0.001
      cpu time  : 0.000


NOTE: AUTOEXEC processing completed

/*           _               _
 _ __    ___| |__   ___  ___| | __
| `__|  / __| `_ \ / _ \/ __| |/ /
| |    | (__| | | |  __/ (__|   <
|_|     \___|_| |_|\___|\___|_|\_\

*/

* run in R gui to read the sas7bdat and convert it to a r dataframe;

library(haven)
library(sqldf)
source("c:/oto/fn_tosas9x.R")
options(sqldf.dll = "d:/dll/sqlean.dll")
iris_sas7bdat<-read_sas("d:/sd1/iris_df.sas7bdat")
print(have)
want<-sqldf('
  select
     *
  from
     iris_sas7bdat
  limit 3
')
want

/*
| | ___   __ _
| |/ _ \ / _` |
| | (_) | (_| |
|_|\___/ \__, |
         |___/
*/

> library(haven)
> library(sqldf)
> source("c:/oto/fn_tosas9x.R")
> options(sqldf.dll = "d:/dll/sqlean.dll")
> iris_sas7bdat<-read_sas("d:/sd1/iris_df.sas7bdat")
> print(have)
# A tibble: 150 × 5
   Sepal_Length Sepal_Width Petal_Length Petal_Width Species
          <dbl>       <dbl>        <dbl>       <dbl> <chr>
 1          5.1         3.5          1.4         0.2 setosa
 2          4.9         3            1.4         0.2 setosa
 3          4.7         3.2          1.3         0.2 setosa
 4          4.6         3.1          1.5         0.2 setosa
 5          5           3.6          1.4         0.2 setosa
 6          5.4         3.9          1.7         0.4 setosa
 7          4.6         3.4          1.4         0.3 setosa
 8          5           3.4          1.5         0.2 setosa
 9          4.4         2.9          1.4         0.2 setosa
10          4.9         3.1          1.5         0.1 setosa
# ? 140 more rows
# ? Use `print(n = ...)` to see more rows
> want<-sqldf('
+   select
+      *
+   from
+      iris_sas7bdat
+   limit 3
+ ')
> want
  Sepal_Length Sepal_Width Petal_Length Petal_Width Species
1          5.1         3.5          1.4         0.2  setosa
2          4.9         3.0          1.4         0.2  setosa
3          4.7         3.2          1.3         0.2  setosa

/*              _
  ___ _ __   __| |
 / _ \ `_ \ / _` |
|  __/ | | | (_| |
 \___|_| |_|\__,_|

*/


























run_powershell_script <- function() {
  # Define the PowerShell script as a string
  ps_script <- '
  Remove-Item -Path "C:\\temp\\done.txt" -ErrorAction SilentlyContinue

  Start-Process "C:\\Program Files\\Altair\\Analytics Workbench\\2025\\eclipse\\workbench.exe"

  # Wait until c:/temp/done.txt exists
  while (-not (Test-Path -Path "C:/temp/done.txt" -PathType Leaf)) {
      Start-Sleep -Seconds 1
  }

  # Kill specific Altair Workbench process by path and task name
  $processPath = "C:\\Program Files\\Altair\\Analytics Workbench\\2025\\eclipse\\workbench.exe"
  $taskName = "workbench"

  # Get matching processes by name
  $targetProcesses = Get-Process -Name $taskName -ErrorAction SilentlyContinue | Where-Object {
      $_.Path -eq $processPath
  }

  # If found, stop them
  if ($targetProcesses) {
      $targetProcesses | Stop-Process -Force
      Write-Output "Process terminated successfully."
  } else {
      Write-Output "No matching process found."
  }
  '

  # Execute the PowerShell script
  result <- system2(
    "powershell",
    args = c("-ExecutionPolicy", "Bypass", "-Command", shQuote(ps_script)),
    stdout = TRUE,
    stderr = TRUE,
    wait = FALSE  # Run asynchronously
  )

  return(result)
}

# Run the function
output <- run_powershell_script()
print(output)

endsubmit;
run;quit;


me demos, 'help()' for on-line help, or
'help.start()' for an HTML browser interface to help.
Type 'q()' to quit R.

[Previously saved workspace restored]

> run_powershell_script <- function() {
+   # Define the PowerShell script as a string
+   ps_script <- '
+   Remove-Item -Path "C:\\temp\\done.txt" -ErrorAction SilentlyContinue
+
+   Start-Process "C:\\Program Files\\Altair\\Analytics Workbench\\2025\\eclipse\\workbench.exe"
+
+   # Wait until c:/temp/done.txt exists
+   while (-not (Test-Path -Path "C:/temp/done.txt" -PathType Leaf)) {
+       Start-Sleep -Seconds 1
+   }
+
+   # Kill specific Altair Workbench process by path and task name
+   $processPath = "C:\\Program Files\\Altair\\Analytics Workbench\\2025\\eclipse\\workbench.exe"
+   $taskName = "workbench"
+
+   # Get matching processes by name
+   $targetProcesses = Get-Process -Name $taskName -ErrorAction SilentlyContinue | Where-Object {
+       $_.Path -eq $processPath
+   }
+
+   # If found, stop them
+   if ($targetProcesses) {
+       $targetProcesses | Stop-Process -Force
+       Write-Output "Process terminated successfully."
+   } else {
+       Write-Output "No matching process found."
+   }
+   '
+
+   # Execute the PowerShell script
+   result <- system2(
+     "powershell",
+     args = c("-ExecutionPolicy", "Bypass", "-Command", shQuote(ps_script)),
+     stdout = TRUE,
+     stderr = TRUE,
+     wait = FALSE  # Run asynchronously
+   )
+
+ return(result)
+ }
>
> output <- run_powershell_script()
> print(output)
[1] "Process terminated successfully."
>

























































































































































































https://www.perplexity.ai/search/cannot-change-security-setting-I8MUhiXrRECNw1eEKYYNIw







Cannot change security settings on win 11, i get failed to ennumerate objects in the container. Access denied.


icacls "d:\wpsa\.metadata" /reset /T /C




Remove-Item -Path C:\temp\done.txt

Start-Process "C:\Program Files\Altair\Analytics Workbench\2025\eclipse\workbench.exe"

# Wait until c:/temp/dne.txt exists
while (-not (Test-Path -Path "C:/temp/done.txt" -PathType Leaf)) {
    Start-Sleep -Seconds 1
}

# Kill specific Altair Workbench process by path and task name

$processPath = "C:\Program Files\Altair\Analytics Workbench\2025\eclipse\workbench.exe"
$taskName = "workbench"

# Get matching processes by name
$targetProcesses = Get-Process -Name $taskName -ErrorAction SilentlyContinue | Where-Object {
    $_.Path -eq $processPath
}

# If found, stop them
if ($targetProcesses) {
    $targetProcesses | Stop-Process -Force
    Write-Output "Process(es) '$taskName' from path '$processPath' have been terminated."
} else {
    Write-Output "No matching process found for '$taskName' at '$processPath'."
}




Stop-Process -Name "workbench" -Force

https://www.perplexity.ai/search/cannot-change-security-setting-I8MUhiXrRECNw1eEKYYNIw



The "Failed to enumerate objects in the container. Access denied" error in Windows 11 typically happens due to permission misconfiguration or conflicts, even when using an administrator account. To resolve this issue, the following steps are effective:

1. Change Ownership:
   - Right-click the folder or object giving the error and select Properties.
   - Go to the Security tab and click Advanced.
   - Click Change next to the Owner field.
   - Enter "Everyone" (or your user account name), click Check Name, then OK.
   - Check "Replace owner of subcontainers and objects" or the equivalent option.
   - Apply changes.

2. Modify Permissions:
   - In the Advanced Security Settings window, click Add.
   - Select "Everyone" as the principal, check Full Control, and apply the changes.

3. Use Command Line to Reset Permissions:
   - Run Command Prompt as Administrator.
   - Execute the command:
     icacls "C:\path\to\folder" /reset /T /C
   - Replace the path with the actual folder path where the error occurs.

These steps restore proper ownership and permissions, often resolving the issue preventing changes to security settings. It is also useful to ensure you are using an Administrator account or running with elevated privileges during these operations. If the problem persists, creating a new user profile or performing a system restore could help.

This guidance consolidates Microsoft Community advice and Windows 11 troubleshooting best practices for managing permission errors with security containers.[1][2][8]

[1](https://www.wisecleaner.com/think-tank/632-6-Ways-to-Fix-the-Access-Denied-Error-on-Windows-11.html)
[2](https://learn.microsoft.com/en-us/answers/questions/3920601/security-issue-failed-to-enumerate-objects-in-the)
[3](https://answers.microsoft.com/en-us/windows/forum/all/windows-11-access-denied-press-continue-to-try-and/c86b6134-7857-418e-830d-cfb19cebfef1)
[4](https://www.reddit.com/r/sysadmin/comments/1ama4n7/failed_to_enumerate_objects_in_the_container/)
[5](https://learn.microsoft.com/en-us/answers/questions/3878256/my-windows-11-system-account-is-being-blocked-by-s)
[6](https://www.youtube.com/watch?v=5fSeccpHtD4)
[7](https://www.reddit.com/r/computerhelp/comments/1bbvmk1/i_cant_access_my_windows_defender_in_windows_11/)
[8](https://www.kapilarya.com/fix-failed-to-enumerate-objects-in-the-container-on-windows-11)
[9](https://www.youtube.com/watch?v=hoNWdYG50so)
[10](https://www.softwarehubs.com/how-to-guide/failed-to-enumerate-objects.html)








data _null_;
infile "D:\wpsa\.metadatabest\.plugins\com.wpc.wps/uuid.txt";
file "d:/txt/uuid.txt";
input;
put _infile_;
run;quit;























%utlfkil(d:/rds/iris.rds)

options set=RHOME "D:\d451";
proc r;
submit;
  data(iris)
  saveRDS(iris, file = "d:/rds/iris.rds")
endsubmit;
run;quit;



libname sd1 sas7bdat "d:/sd1";

proc datasets lib=sd1 nodetails nolist;
 delete iris_df;
run;quit;

options set=RHOME "D:\d451";
proc r;
submit;
  iris_df<- readRDS("d:/rds/iris.rds")
endsubmit;
import data=sd1.iris_df r=iris_df;
run;quit;




please provide powershell program to kill a workbench task given

C:\Program Files\Altair\Analytics Workbench\2025\eclipse\workbench.exe and
taskname workbench























$path = "d:\wpsa\.metadata\.plugins"
$allItems = Get-ChildItem -Path $path -Recurse -Force
$readOnlyItems = $allItems | Where-Object { $_.IsReadOnly }

Write-Host "Total items: $($allItems.Count)"
Write-Host "Read-only items: $($readOnlyItems.Count)"
Write-Host "Normal items: $($allItems.Count - $readOnlyItems.Count)"

# List the read-only items
$readOnlyItems | Format-Table FullName, Attributes, @{Name="Type";Expression={if($_.PSIsContainer){"Folder"}else{"File"}}}





how do i make the altair eclipse slc ask me to select a specific metadata when opening the altair slc










attrib -r "d:\wpsa\.metadata\.plugins" /s /d









Get-ChildItem -Path "d:\wpsa\.metadata" -Recurse | ForEach-Object { $_.IsReadOnly = $false }




The win 11 folder d:\wpsa\.metadata has a blue '-' in the readonly attribute, when I try to
remove the '-' by clicking on rhw '-'  to every file it fails. How do i set read only for all sub folders and files









The following does not work

Get-ChildItem -Path "d:\wpsa\.metadata" -Recurse -File | ForEach-Object { $_.IsReadOnly = $false }

The



make the entire folder read only I get the following error

PS C:\Windows\System32> Get-ChildItem -Path "d:\wpsa\.metadata" -Recurse | ForEach-Object { $_.IsReadOnly = $false }
>>
The property 'IsReadOnly' cannot be found on this object. Verify that the property exists and can be set.
At line:1 char:69
+ ... \wpsa\.metadata" -Recurse | ForEach-Object { $_.IsReadOnly = $false }
+                                                  ~~~~~~~~~~~~~~~~~~~~~~
    + CategoryInfo          : InvalidOperation: (:) [], RuntimeException
    + FullyQualifiedErrorId : PropertyAssignmentException









































Get-ChildItem -Path "d:\wpsa\.metadata" -Recurse -File | ForEach-Object { $_.IsReadOnly = $false }






Start-Process "C:\Program Files\Altair\Analytics Workbench\2025\eclipse\workbench.exe"

# Wait until c:/temp/dne.txt exists
while (-not (Test-Path -Path "C:/temp/done.txt" -PathType Leaf)) {
    Start-Sleep -Seconds 1
}

Stop-Process -Name "workbench" -Force

























# Define the folder path
$folderPath = "D:\wpsa\.metadatabest"

# Define the user or group you want to assign permissions to
$user = "R7610\Roger"

# Get the current ACL
$acl = Get-Acl $folderPath

# Create a new access rule to add (e.g., FullControl for the user)
$accessRule = New-Object System.Security.AccessControl.FileSystemAccessRule($user, "FullControl", "ContainerInherit,ObjectInherit", "None", "Allow")

# Add the new access rule to the ACL
$acl.AddAccessRule($accessRule)

# Set the ACL back to the folder
Set-Acl -Path $folderPath -AclObject $acl

# To apply permissions recursively to all files and subfolders:
Get-ChildItem -Path $folderPath -Recurse | ForEach-Object {
    $itemAcl = Get-Acl $_.FullName
    $itemAcl.AddAccessRule($accessRule)
    Set-Acl -Path $_.FullName -AclObject $itemAcl
}





https://chat.deepseek.com/a/chat/s/2daefe45-c732-43b3-b055-76ad3140982e


how do i copy all folders and subfolders and files to a new folder, with full control on new folders and files using powershell




# Source and destination paths
$source = "D:\wpsa\.metadatabest"
$destination = "D:\wpsa\.metadatabestcopy"

# Use robocopy for better file and permission handling
robocopy $source $destination /E /COPYALL /DCOPY:DAT /R:3 /W:5

















































 # Source and destination paths
$source = "D:\wpsa\.metadatabest"
$destination = "D:\wpsa\.metadatabestcopy"

# Use robocopy for better file and permission handling
robocopy $source $destination /E /COPYALL /DCOPY:DAT /R:3 /W:5





# Source and destination paths
$source = "D:\wpsa\.metadatabest"
$destination = "D:\wpsa\.metadatabestcopy"

# Use robocopy for better file and permission handling
robocopy $source $destination /E /COPYALL /DCOPY:DAT /R:3 /W:5


robocopy $source $destination /E /COPY:DATSOU /DCOPY:DAT /R:3 /W:5


function Copy-FolderWithCleanAttributes {
    param(
        [string]$SourcePath,
        [string]$DestinationPath
    )

    # Create destination if it doesn't exist
    if (!(Test-Path $DestinationPath)) {
        New-Item -ItemType Directory -Path $DestinationPath -Force
    }

    # Copy using robocopy without system attributes
    Write-Host "Copying files and folders..." -ForegroundColor Green
    robocopy $SourcePath $DestinationPath /E /COPY:DTSOU /DCOPY:DAT /R:3 /W:5 /NP

    # Remove compressed attribute
    Write-Host "Cleaning up attributes..." -ForegroundColor Green
    attrib -C "$DestinationPath\*" /S /D

    # Set full control permissions
    Write-Host "Setting permissions..." -ForegroundColor Green
    $acl = Get-Acl $SourcePath
    Set-Acl -Path $DestinationPath -AclObject $acl

    Get-ChildItem -Path $DestinationPath -Recurse | ForEach-Object {
        Set-Acl -Path $_.FullName -AclObject $acl
    }

    Write-Host "Copy completed successfully!" -ForegroundColor Green
}

# Usage
Copy-FolderWithCleanAttributes -SourcePath "D:\wpsa\.metadatabest" -DestinationPath "D:\wpsa\.metadatabestcopy"



function Copy-FolderWithoutCompression {
    param(
        [string]$SourcePath,
        [string]$DestinationPath
    )

    Write-Host "Copying files and folders..." -ForegroundColor Green

    # Copy without attribute preservation to avoid compression
    robocopy $SourcePath $DestinationPath /E /COPY:DTSU /DCOPY:DT /R:3 /W:5 /NP

    Write-Host "Removing compression..." -ForegroundColor Green

    # Method 1: Try attrib command
    $attribProcess = Start-Process -FilePath "attrib" -ArgumentList "-C `"$DestinationPath\*`" /S /D" -Wait -PassThru -NoNewWindow

    if ($attribProcess.ExitCode -ne 0) {
        Write-Host "Attrib failed, trying compact command..." -ForegroundColor Yellow
        # Method 2: Use compact command
        Start-Process -FilePath "compact" -ArgumentList "/U `"$DestinationPath`" /S /I" -Wait -NoNewWindow
    }

    Write-Host "Setting permissions..." -ForegroundColor Green

    # Set full control for everyone (modify as needed)
    $acl = Get-Acl $SourcePath
    $rule = New-Object System.Security.AccessControl.FileSystemAccessRule(
        "Everyone",
        "FullControl",
        "ContainerInherit,ObjectInherit",
        "None",
        "Allow"
    )
    $acl.AddAccessRule($rule)
    Set-Acl -Path $DestinationPath -AclObject $acl

    # Apply to all subitems
    Get-ChildItem -Path $DestinationPath -Recurse | ForEach-Object {
        Set-Acl -Path $_.FullName -AclObject $acl
    }

    Write-Host "Copy completed successfully!" -ForegroundColor Green
}

# Usage
Copy-FolderWithoutCompression  -SourcePath "D:\wpsa\.metadatabest" -DestinationPath "D:\wpsa\.metadatabestcopy"




attrib -R "D:\wpsa\.metadatabestcopy" /S /D




$destination = "D:\wpsa\.metadatabestcopy"
takeown /f "$destination" /r /d y
icacls "$destination" /grant:r "Everyone:F" /t

# Then remove read-only
attrib -R "$destination\*" /S /D




function Copy-FolderCleanAttributes {
    param(
        [string]$SourcePath,
        [string]$DestinationPath
    )

    # Create destination
    if (!(Test-Path $DestinationPath)) {
        New-Item -ItemType Directory -Path $DestinationPath -Force
    }

    Write-Host "Copying files and folders..." -ForegroundColor Green

    # Copy with robocopy - don't copy attributes to avoid read-only issues
    robocopy $SourcePath $DestinationPath /E /COPY:DTSU /DCOPY:DT /R:3 /W:5 /NP

    Write-Host "Cleaning up attributes..." -ForegroundColor Green

    # Remove read-only attribute using multiple methods
    try {
        # Method 1: Using attrib command
        $process = Start-Process -FilePath "attrib" -ArgumentList "-R `"$DestinationPath\*`" /S /D" -Wait -PassThru -NoNewWindow
        if ($process.ExitCode -ne 0) {
            Write-Warning "Attrib command failed, trying alternative method..."
        }
    }
    catch {
        Write-Warning "Attrib failed: $($_.Exception.Message)"
    }

    # Method 2: PowerShell fallback
    Get-ChildItem -Path $DestinationPath -Recurse -Force | ForEach-Object {
        try {
            if ($_.Attributes -band [System.IO.FileAttributes]::ReadOnly) {
                $_.Attributes = $_.Attributes -band (-bnot [System.IO.FileAttributes]::ReadOnly)
            }
        }
        catch {
            Write-Warning "Could not modify attributes for: $($_.FullName)"
        }
    }

    Write-Host "Setting full control permissions..." -ForegroundColor Green

    # Set full control permissions
    $acl = Get-Acl $SourcePath

    # Add full control for everyone
    $rule = New-Object System.Security.AccessControl.FileSystemAccessRule(
        "Everyone",
        "FullControl",
        "ContainerInherit,ObjectInherit",
        "None",
        "Allow"
    )
    $acl.AddAccessRule($rule)

    # Apply to destination and all subitems
    Set-Acl -Path $DestinationPath -AclObject $acl
    Get-ChildItem -Path $DestinationPath -Recurse | ForEach-Object {
        try {
            Set-Acl -Path $_.FullName -AclObject $acl
        }
        catch {
            Write-Warning "Could not set permissions for: $($_.FullName)"
        }
    }

    Write-Host "Copy completed successfully!" -ForegroundColor Green
}

# Usage
Copy-FolderCleanAttributes -SourcePath "D:\wpsa\.metadatabest" -DestinationPath "D:\wpsa\.metadatabestcopy"




$destination = "D:\wpsa\.metadatabestcopy"

# Remove read-only attribute using PowerShell
Get-ChildItem -Path $destination -Recurse | ForEach-Object {
    if ($_.Attributes -band [System.IO.FileAttributes]::ReadOnly) {
        $newAttributes = $_.Attributes -band (-bnot [System.IO.FileAttributes]::ReadOnly)
        $_.Attributes = $newAttributes
    }
}


$source = "D:\wpsa\.metadatabest"
$destination = "D:\wpsa\.metadatabestcopy"


# Delete and completely recreate the destination
if (Test-Path $destination) {
    Remove-Item $destination -Recurse -Force
}

# Create fresh destination
New-Item -ItemType Directory -Path $destination -Force

# Copy files only (not folder attributes)
robocopy $source $destination /E /COPY:DTSU /DCOPY:DT /R:3 /W:5

# Set fresh permissions
$acl = Get-Acl $source
Set-Acl -Path $destination -AclObject $acl
Get-ChildItem -Path $destination -Recurse | ForEach-Object {
    Set-Acl -Path $_.FullName -AclObject $acl
}


$destination = "D:\wpsa\.metadatabestcopy"
Get-ChildItem -Path $destination -Recurse -File | Where-Object { $_.IsReadOnly } | ForEach-Object {
    $_.IsReadOnly = $false
    Write-Host "Removed read-only from: $($_.Name)"
}
