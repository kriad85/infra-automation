for filename in deployment/output/*; do
    kubectl apply -f $filename
done
