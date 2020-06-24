I created separate POC application to show slowness in MVC based on how we update the model.
When we emit updates to the model for each entry in the model it becomes slow. 
When we emit updates only when model is updated fully its comparatively faster.