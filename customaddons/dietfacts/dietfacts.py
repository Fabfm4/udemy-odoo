# Dietfacts application
from openerp import models, fields


# Extend product.template model with calories
class DietFacts_produt_template(models.Model):
    _name = 'product.template'
    _inherit = 'product.template'

    calories = fields.Integer("Calories")
