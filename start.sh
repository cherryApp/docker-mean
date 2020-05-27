# Run this scripts where system is started.
echo "Hello, World"
pm2 start /app/server/bin/www
sleep 2
cd /app/client
ng serve --host 0.0.0.0
