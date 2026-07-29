FROM ghcr.io/salamsoft-tech/odoo@sha256:89b21128a693f1ba6211ef329533697a9d13acd0115b383811a4f89d605e843a

ARG OPENUPGRADE_COMMIT=2f6a086e66583eaf971d73372c8a101bafe524b5

RUN git clone https://github.com/OCA/OpenUpgrade /mnt/ou \
    && git -C /mnt/ou checkout ${OPENUPGRADE_COMMIT} \
    && pip3 install --break-system-packages openupgradelib==3.13.5
