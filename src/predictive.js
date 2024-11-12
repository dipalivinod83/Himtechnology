class PredictiveModel {
    constructor() {
        this.wasmModule = null;
        this.init();
    }

    async init() {
        try {
            this.wasmModule = await WebAssembly.instantiateStreaming(
                fetch('predictive_model.wasm'),
                {
                    env: {
                        memory: new WebAssembly.Memory({ initial: 256 }),
                        abort: () => console.log('Abort!')
                    }
                }
            );
        } catch (error) {
            console.error('Failed to load WASM module:', error);
        }
    }

    predict(sales, customers) {
        if (!this.wasmModule) {
            throw new Error('WASM module not initialized');
        }

        const salesArray = new Float32Array([sales]);
        const customersArray = new Float32Array([customers]);
        
        return this.wasmModule.instance.exports.runPrediction(
            salesArray.buffer,
            customersArray.buffer,
            1
        );
    }
} 