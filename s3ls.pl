#! /usr/bin/perl


#get a list of buckets on s3
sub getBuckets
{
  #How buckets are listed if you run : aws s3 ls
  #2020-06-27 15:27:03 s3-944-deferredmaster-or-1
  #2020-06-27 15:27:03 s3-944-masters-or-1
  #2020-06-27 15:27:03 s3-944-sitedoc-or-1
  #2020-06-27 15:30:16 s3-fremantle-ancillary-or-1
  #2021-03-18 11:20:26 s3-fremantle-aus-or-1
  #2020-06-16 17:50:10 s3-fremantle-aus-syd-1
  #2020-06-27 15:30:16 s3-fremantle-ausmasters-or-1
  #2020-08-24 13:16:53 s3-fremantle-ccfiles-or-1
  #2020-06-27 15:30:16 s3-fremantle-intl-or-1
  #2020-06-27 15:30:16 s3-fremantle-intlmasters-or-1
  #2020-06-27 15:30:16 s3-fremantle-uk-or-1
  #2020-06-27 15:30:16 s3-fremantle-ukmasters-or-1
  #2020-07-14 13:00:21 s3-fremantle-videomaster-or-1

  $cmd = "aws s3 ls";

  unless (open CMD, "$cmd |")
  {
    print("~~Cannot execute $cmd~~\n");
    exit(1);
  }

  while(<CMD>)
  {
    chomp;
    print("$_\n");
  }

  close(CMD)

}


&getBuckets;
