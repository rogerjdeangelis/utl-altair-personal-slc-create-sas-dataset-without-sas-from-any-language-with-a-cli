# utl-altair-personal-slc-create-sas-dataset-without-sas-from-any-language-with-a-cli
Altair personal slc create sas dataset without sas from any language with a cli (R PYTHON...)
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

