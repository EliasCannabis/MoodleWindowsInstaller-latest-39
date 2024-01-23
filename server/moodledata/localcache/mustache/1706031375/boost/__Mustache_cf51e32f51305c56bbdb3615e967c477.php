<?php

class __Mustache_cf51e32f51305c56bbdb3615e967c477 extends Mustache_Template
{
    public function renderInternal(Mustache_Context $context, $indent = '')
    {
        $buffer = '';

        if ($partial = $this->mustache->loadPartial('core_form/element-text-inline')) {
            $buffer .= $partial->renderInternal($context);
        }

        return $buffer;
    }
}
