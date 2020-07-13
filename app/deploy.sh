for filename in deployment/output/*; do
    kubectl apply -f $filename
    sleep 10
done
