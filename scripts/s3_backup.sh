
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
