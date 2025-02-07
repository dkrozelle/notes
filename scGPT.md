
foundation model is designed to be a generalizable feature extractor that can benefit a diverse range of downstream tasks. The token vocabulary used in pre-training contains the entire set of genes in the human genome

## input processing

To address this scale difference, we propose the value binning technique to convert all expression counts into relative values

e calculate the raw absolute values and divide them into B consecutive intervals

for fine-tuning tasks, we also performed log1p transformation and highly variable gene selection before the value binning step.

Each interval represents an equal portion of all expressed genes (1/B). It is important to note that a new set of bin edges is computed for each cell, so the interval edges bk may vary among cells.

## cell type annotation

what type of data is required to fine-tune models for such tasks?

For the cell type annotation task, we fine-tuned the model on a reference set with ground-truth labels

gene expression values were normalized, log-transformed, and binned prior to model fine-tuning

emphasizes the importance of aligning the cellular context in pre-
training with the target dataset for superior results in downstream tasks

While considering the cellular context is essential, the whole-human pre-trained model emerges as a versatile and reliable option for a wide range of applications.

## Gene Regulatory Network Inference (GRN)

gene-embedding-based GRN inference

Since scgpt uses generative modelling of gene expression, it implicitly encodes relationships in its gene embeddings as well as attention maps

For the gene-embedding-based GRN inference, in the zero-shot setting, we constructed the gene similarity network from the pretrained scGPT’s gene embeddings based on k-nearest neighbors.

scGPT’s attention mechanism enables it to capture gene-gene interactions at the single-cell level


## multimodal integration

non-RNA embeddings were trained from scratch during the fine-tuning phase since these are not included in the foundation model.

We used an additional set of modality tokens to indicate the data type of each token (i.e., gene, region, or protein)