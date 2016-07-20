
#Vars
source /opt/global_vars.txt
DRUSH="/usr/bin/drush -y --nocolor"
CURRDATE=`date +%Y%m%d_%H%M`
COMPANY1_DBBACKUP="${COMPANY1}_db_${CURRDATE}.sql.gz"
COMPANY2_DBBACKUP="${COMPANY2}_db_${CURRDATE}.sql.gz"
DBNAME=`drush sql-connect | awk '{print $2}' | sed 's/--database=//g'`

#Company 1
    echo "Backing up ${COMPANY1}"

    #Backup
    eval `drush sql-connect | sed 's/database=/databases /g' | sed 's/mysql/mysqldump/g'` | gzip > /home/homepage/tmp/${COMPANY1_DBBACKUP} ;

    #Copy to S3
    echo "Copying $COMPANY1_DBBACKUP to S3://${BACKUP_BUCKET}/${COMPANY1}_dbbackup/${COMPANY1_DBBACKUP}"

    aws s3 cp /home/homepage/tmp/${COMPANY1_DBBACKUP} s3://${BACKUP_BUCKET}/${COMPANY1}_dbbackup/${COMPANY1_DBBACKUP} || return $?
    rm /home/homepage/tmp/${COMPANY1_DBBACKUP} || return $?

#Company 2
    echo "Backing up ${COMPANY2}"

    #Backup
    eval `drush sql-connect | sed 's/database=/databases /g' | sed 's/mysql/mysqldump/g'` | gzip > /home/homepage.la-z-boyga.com/tmp/${COMPANY2_DBBACKUP} ;

    #Copy to S3
    echo "Copying $COMPANY2_DBBACKUP to S3://${BACKUP_BUCKET}/${COMPANY2}_dbbackup/${COMPANY2_DBBACKUP}"

    aws s3 cp /home/homepage.la-z-boyga.com/tmp/${COMPANY2_DBBACKUP} s3://${BACKUP_BUCKET}/fga_dbbackup/${COMPANY2_DBBACKUP} || return $?
    rm /home/homepage.la-z-boyga.com/tmp/${COMPANY2_DBBACKUP} || return $?

#Rotate last 10 days for ${COMPANY1}
    echo "Rotating backups to keep only 10 days"
    today=`aws s3 ls --profile prod s3://$BACKUP_BUCKET/${COMPANY1}_dbbackup/ | sort -n -r | head -1 | awk '{print $4}'`
    day1=`aws s3 ls --profile prod s3://$BACKUP_BUCKET/${COMPANY1}_dbbackup/ | sort -n -r | head -2 | awk '{print $4}' | awk 'NR==2'`
    day2=`aws s3 ls --profile prod s3://$BACKUP_BUCKET/${COMPANY1}_dbbackup/ | sort -n -r | head -3 | awk '{print $4}' | awk 'NR==3'`
    day3=`aws s3 ls --profile prod s3://$BACKUP_BUCKET/${COMPANY1}_dbbackup/ | sort -n -r | head -4 | awk '{print $4}' | awk 'NR==4'`
    day4=`aws s3 ls --profile prod s3://$BACKUP_BUCKET/${COMPANY1}_dbbackup/ | sort -n -r | head -5 | awk '{print $4}' | awk 'NR==5'`
    day5=`aws s3 ls --profile prod s3://$BACKUP_BUCKET/${COMPANY1}_dbbackup/ | sort -n -r | head -6 | awk '{print $4}' | awk 'NR==6'`
    day6=`aws s3 ls --profile prod s3://$BACKUP_BUCKET/${COMPANY1}_dbbackup/ | sort -n -r | head -7 | awk '{print $4}' | awk 'NR==7'`
    day7=`aws s3 ls --profile prod s3://$BACKUP_BUCKET/${COMPANY1}_dbbackup/ | sort -n -r | head -8 | awk '{print $4}' | awk 'NR==8'`
    day8=`aws s3 ls --profile prod s3://$BACKUP_BUCKET/${COMPANY1}_dbbackup/ | sort -n -r | head -9 | awk '{print $4}' | awk 'NR==9'`
    day9=`aws s3 ls --profile prod s3://$BACKUP_BUCKET/${COMPANY1}_dbbackup/ | sort -n -r | head -10 | awk '{print $4}' | awk 'NR==10'`

    aws s3 rm s3://$BACKUP_BUCKET/${COMPANY1}_dbbackup/ --recursive --exclude "$today" --exclude "$day1" --exclude "$day2" --exclude "$day3" --exclude "$day4" --exclude "$day5" --exclude "$day6" --exclude "$day7" --exclude "$day8" --exclude "$day9"

#Rotate last 10 days for ${COMPANY2}
        echo "Rotating backups to keep only 10 days"
        today=`aws s3 ls --profile prod s3://$BACKUP_BUCKET/${COMPANY2}_dbbackup/ | sort -n -r | head -1 | awk '{print $4}'`
        day1=`aws s3 ls --profile prod s3://$BACKUP_BUCKET/${COMPANY2}_dbbackup/ | sort -n -r | head -2 | awk '{print $4}' | awk 'NR==2'`
        day2=`aws s3 ls --profile prod s3://$BACKUP_BUCKET/${COMPANY2}_dbbackup/ | sort -n -r | head -3 | awk '{print $4}' | awk 'NR==3'`
        day3=`aws s3 ls --profile prod s3://$BACKUP_BUCKET/${COMPANY2}_dbbackup/ | sort -n -r | head -4 | awk '{print $4}' | awk 'NR==4'`
        day4=`aws s3 ls --profile prod s3://$BACKUP_BUCKET/${COMPANY2}_dbbackup/ | sort -n -r | head -5 | awk '{print $4}' | awk 'NR==5'`
        day5=`aws s3 ls --profile prod s3://$BACKUP_BUCKET/${COMPANY2}_dbbackup/ | sort -n -r | head -6 | awk '{print $4}' | awk 'NR==6'`
        day6=`aws s3 ls --profile prod s3://$BACKUP_BUCKET/${COMPANY2}_dbbackup/ | sort -n -r | head -7 | awk '{print $4}' | awk 'NR==7'`
        day7=`aws s3 ls --profile prod s3://$BACKUP_BUCKET/${COMPANY2}_dbbackup/ | sort -n -r | head -8 | awk '{print $4}' | awk 'NR==8'`
        day8=`aws s3 ls --profile prod s3://$BACKUP_BUCKET/${COMPANY2}_dbbackup/ | sort -n -r | head -9 | awk '{print $4}' | awk 'NR==9'`
        day9=`aws s3 ls --profile prod s3://$BACKUP_BUCKET/${COMPANY2}_dbbackup/ | sort -n -r | head -10 | awk '{print $4}' | awk 'NR==10'`

        aws s3 rm s3://$BACKUP_BUCKET/${COMPANY2}_dbbackup/ --recursive --exclude "$today" --exclude "$day1" --exclude "$day2" --exclude "$day3" --exclude "$day4" --exclude "$day5" --exclude "$day6" --exclude "$day7" --exclude "$day8" --exclude "$day9"
