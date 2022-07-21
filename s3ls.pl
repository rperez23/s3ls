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

  @bList = ();

  $cmd = "aws s3 ls";

  unless (open CMD, "$cmd |")
  {
    print("~~Cannot execute $cmd~~\n");
    exit(1);
  }

  while(<CMD>)
  {
    chomp;

    if (/^\d{4}-\d{2}-\d{2}\s+\d{2}:\d{2}:\d{2}\s+(.+)$/)
    {
      $bucket = $1;
      push(@bList,$bucket);
    }

  }

  close(CMD);

  return (@bList);

}

#run an ls of a bucket
sub runlscmd
{
  $cmd    = $_[0];
  $bucket = $_[1];

  #2022-02-22 13:17:57          0 Blackbird Ingest/
  #2022-02-28 10:54:59          0 Blackbird_Ingest_HD/
  #2022-04-11 17:58:17          0 Blackbird_Ingest_HD/Home Channel/
  #2022-02-28 10:55:43          0 Blackbird_Ingest_SD/
  #2022-02-28 11:12:12 25041107457 Blackbird_Ingest_SD/LMAD_EP3001_SR0003_YR2011_WB.mov

  unless (open CMD, "$cmd |")
  {
    print("~~Cannot execute $cmd~~\n");
    exit(1);
  }

  while(<CMD>)
  {
    chomp;

    if (/^\d{4}-\d{2}-\d{2}\s+\d{2}:\d{2}:\d{2}\s+(\d+)\s+(.+)$/)
    {
      $size  = $1;
      $fname = "$bucket/$2";
      print("$fname\n");
    }

  }

  close(CMD);
}

@bucketList = &getBuckets;


foreach $b (@bucketList)
{

  $cmd = "aws s3 ls --recursive \"s3://$b\"";

  &runlscmd($cmd,$b)

}
