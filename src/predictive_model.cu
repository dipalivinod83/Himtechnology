#include <cuda_runtime.h>

extern "C" {
    __global__ void predictiveModelKernel(
        float* sales, 
        float* customers, 
        float* results, 
        int size
    ) {
        int idx = blockIdx.x * blockDim.x + threadIdx.x;
        if (idx < size) {
            // Simple predictive model example
            // You can modify this with your actual prediction logic
            results[idx] = sales[idx] * 0.15f + customers[idx] * 0.25f;
        }
    }

    float* runPrediction(float* sales, float* customers, int size) {
        float *d_sales, *d_customers, *d_results, *h_results;
        
        // Allocate device memory
        cudaMalloc(&d_sales, size * sizeof(float));
        cudaMalloc(&d_customers, size * sizeof(float));
        cudaMalloc(&d_results, size * sizeof(float));
        
        // Copy input data to device
        cudaMemcpy(d_sales, sales, size * sizeof(float), cudaMemcpyHostToDevice);
        cudaMemcpy(d_customers, customers, size * sizeof(float), cudaMemcpyHostToDevice);
        
        // Launch kernel
        int blockSize = 256;
        int numBlocks = (size + blockSize - 1) / blockSize;
        predictiveModelKernel<<<numBlocks, blockSize>>>(d_sales, d_customers, d_results, size);
        
        // Copy results back to host
        h_results = (float*)malloc(size * sizeof(float));
        cudaMemcpy(h_results, d_results, size * sizeof(float), cudaMemcpyDeviceToHost);
        
        // Cleanup
        cudaFree(d_sales);
        cudaFree(d_customers);
        cudaFree(d_results);
        
        return h_results;
    }
} 